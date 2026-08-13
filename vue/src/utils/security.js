const DANGEROUS_TAGS = ['script', 'style', 'iframe', 'object', 'embed', 'svg', 'math'];

const RICH_TEXT_ALLOWED_TAGS = [
  'a',
  'b',
  'blockquote',
  'br',
  'code',
  'div',
  'em',
  'h1',
  'h2',
  'h3',
  'h4',
  'h5',
  'h6',
  'i',
  'img',
  'li',
  'ol',
  'p',
  'pre',
  's',
  'span',
  'strong',
  'u',
  'ul',
];

const DISPLAY_ALLOWED_TAGS = ['b', 'br', 'code', 'div', 'em', 'i', 'pre', 's', 'span', 'strong', 'u'];

const GLOBAL_ATTRS = ['class', 'style', 'title'];

const TAG_ATTRS = {
  a: ['href', 'target', 'rel'],
  img: ['src', 'alt', 'width', 'height'],
};

const ALLOWED_STYLE_PROPS = [
  'background-color',
  'border',
  'border-radius',
  'color',
  'display',
  'font-size',
  'font-style',
  'font-weight',
  'height',
  'line-height',
  'margin',
  'margin-bottom',
  'margin-left',
  'margin-right',
  'margin-top',
  'max-width',
  'min-width',
  'overflow',
  'padding',
  'text-align',
  'text-decoration',
  'white-space',
  'width',
];

const XSS_RISK_PATTERNS = [
  /<\s*script\b/i,
  /<\s*iframe\b/i,
  /<\s*object\b/i,
  /<\s*embed\b/i,
  /<\s*svg\b/i,
  /<\s*math\b/i,
  /\bon[a-z]+\s*=/i,
  /javascript\s*:/i,
  /vbscript\s*:/i,
  /data\s*:\s*text\/html/i,
  /expression\s*\(/i,
  /url\s*\(\s*['"]?\s*javascript\s*:/i,
];

function includes(list, value) {
  return list.indexOf(value) !== -1;
}

function decodeHtmlEntities(value) {
  if (typeof document === 'undefined') {
    return value;
  }
  const textarea = document.createElement('textarea');
  textarea.innerHTML = value;
  return textarea.value;
}

function normalizeForScan(value) {
  let text = String(value);
  try {
    text = decodeURIComponent(text);
  } catch (e) {
    text = String(value);
  }
  return decodeHtmlEntities(text)
    .replace(/[\u0000-\u001F\u007F]/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

function isSafeUrl(value, allowImageData) {
  if (!value) {
    return false;
  }
  const url = normalizeForScan(value).replace(/[\u0000-\u001F\u007F\s]/g, '');
  const lowerUrl = url.toLowerCase();

  if (/^(javascript|vbscript):/i.test(lowerUrl)) {
    return false;
  }
  if (/^data:/i.test(lowerUrl)) {
    return allowImageData && /^data:image\/(png|jpe?g|gif|webp);base64,/i.test(lowerUrl);
  }
  if (/^[a-z][a-z0-9+.-]*:/i.test(lowerUrl)) {
    return /^(https?|mailto|tel):/i.test(lowerUrl);
  }
  return true;
}

function sanitizeStyle(styleText) {
  return String(styleText)
    .split(';')
    .map((item) => {
      const index = item.indexOf(':');
      if (index === -1) {
        return '';
      }
      const name = item.substring(0, index).trim().toLowerCase();
      const value = item.substring(index + 1).trim();
      if (!includes(ALLOWED_STYLE_PROPS, name)) {
        return '';
      }
      if (/expression\s*\(|url\s*\(|javascript\s*:|vbscript\s*:|data\s*:/i.test(value)) {
        return '';
      }
      if (!/^[#(),.%\w\s-]+$/.test(value)) {
        return '';
      }
      return `${name}: ${value}`;
    })
    .filter(Boolean)
    .join('; ');
}

function sanitizeClass(classText) {
  return String(classText)
    .split(/\s+/)
    .filter((className) => /^(ql-|hljs|language-)[\w-]*$/.test(className))
    .join(' ');
}

function isAllowedAttr(tagName, attrName) {
  return includes(GLOBAL_ATTRS, attrName) || (TAG_ATTRS[tagName] && includes(TAG_ATTRS[tagName], attrName));
}

function unwrapNode(node) {
  const parent = node.parentNode;
  if (!parent) {
    return;
  }
  while (node.firstChild) {
    parent.insertBefore(node.firstChild, node);
  }
  parent.removeChild(node);
}

function sanitizeElement(node, allowedTags) {
  const tagName = node.nodeName.toLowerCase();
  if (includes(DANGEROUS_TAGS, tagName)) {
    node.parentNode.removeChild(node);
    return;
  }
  if (!includes(allowedTags, tagName)) {
    sanitizeChildren(node, allowedTags);
    unwrapNode(node);
    return;
  }

  Array.from(node.attributes).forEach((attr) => {
    const attrName = attr.name.toLowerCase();
    const attrValue = attr.value;
    if (/^on/i.test(attrName) || !isAllowedAttr(tagName, attrName)) {
      node.removeAttribute(attr.name);
      return;
    }
    if ((attrName === 'href' || attrName === 'src') && !isSafeUrl(attrValue, tagName === 'img')) {
      node.removeAttribute(attr.name);
      return;
    }
    if (attrName === 'style') {
      const safeStyle = sanitizeStyle(attrValue);
      if (safeStyle) {
        node.setAttribute('style', safeStyle);
      } else {
        node.removeAttribute('style');
      }
      return;
    }
    if (attrName === 'class') {
      const safeClass = sanitizeClass(attrValue);
      if (safeClass) {
        node.setAttribute('class', safeClass);
      } else {
        node.removeAttribute('class');
      }
      return;
    }
    if (tagName === 'a' && attrName === 'target') {
      if (attrValue === '_blank') {
        node.setAttribute('rel', 'noopener noreferrer');
      } else {
        node.removeAttribute(attr.name);
      }
    }
  });

  sanitizeChildren(node, allowedTags);
}

function sanitizeChildren(parent, allowedTags) {
  Array.from(parent.childNodes).forEach((node) => {
    if (node.nodeType === 1) {
      sanitizeElement(node, allowedTags);
    } else if (node.nodeType !== 3) {
      node.parentNode.removeChild(node);
    }
  });
}

function sanitizeHtml(html, allowedTags) {
  if (html === null || html === undefined) {
    return '';
  }
  if (typeof document === 'undefined') {
    return escapeHtml(html);
  }
  const template = document.createElement('template');
  template.innerHTML = String(html);
  sanitizeChildren(template.content || template, allowedTags);
  return template.innerHTML;
}

export function escapeHtml(value) {
  if (value === null || value === undefined) {
    return '';
  }
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

export function sanitizeRichText(html) {
  return sanitizeHtml(html, RICH_TEXT_ALLOWED_TAGS);
}

export function sanitizeDisplayHtml(html) {
  return sanitizeHtml(html, DISPLAY_ALLOWED_TAGS);
}

export function hasXssRisk(value) {
  if (value === null || value === undefined) {
    return false;
  }
  if (Array.isArray(value)) {
    return value.some((item) => hasXssRisk(item));
  }
  if (typeof value === 'object') {
    return Object.keys(value).some((key) => hasXssRisk(value[key]));
  }
  const text = normalizeForScan(value);
  return XSS_RISK_PATTERNS.some((pattern) => pattern.test(text));
}
