let rgb2hsl = function(r, g, b) {
  r /= 255, g /= 255, b /= 255;
  var max = Math.max(r, g, b),
    min = Math.min(r, g, b);
  var h, s, l = (max + min) / 2;

  if (max == min) {
    h = s = 0; // achromatic
  } else {
    var d = max - min;
    s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
    switch (max) {
      case r:
        h = (g - b) / d + (g < b ? 6 : 0);
        break;
      case g:
        h = (b - r) / d + 2;
        break;
      case b:
        h = (r - g) / d + 4;
        break;
    }
    h /= 6;
  }
  return [h, s, l];
}

let hslToRgb = function(h, s, l) {
  var r, g, b;
  if (s == 0) {
    r = g = b = l; // achromatic
  } else {
    var hue2rgb = function hue2rgb(p, q, t) {
      if (t < 0) t += 1;
      if (t > 1) t -= 1;
      if (t < 1 / 6) return p + (q - p) * 6 * t;
      if (t < 1 / 2) return q;
      if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
      return p;
    }
    var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    var p = 2 * l - q;
    r = hue2rgb(p, q, h + 1 / 3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1 / 3);
  }
  return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
}

let drawRing = function(ctx, width, height) {
  // 画圆环
  var radius = width / 2;
  var toRad = (2 * Math.PI) / 360;
  var step = 0.1;
  for (var i = 0; i < 360; i += step) {
    var rad = i * toRad;
    var color = hslToRgb(i / 360, 1, 0.5);
    ctx.strokeStyle = `rgb(${color[0]},${color[1]},${color[2]})`;
    ctx.beginPath();
    ctx.moveTo(radius, radius);
    ctx.lineTo(radius + radius * Math.cos(rad), radius + radius * Math.sin(rad));
    ctx.stroke();
  }

  ctx.fillStyle = 'rgb(255, 255, 255)';
  ctx.strokeStyle = 'rgb(0, 255, 255)';
  ctx.beginPath();
  ctx.arc(radius, radius, radius * 0.65, 0, Math.PI * 2, true);
  ctx.closePath();
  ctx.fill();
  ctx.draw();
};

let drawSlider = function(ctx, width, height, angle) {
  var radius = width / 2;

  ctx.save();
  ctx.clearRect(0, 0, width, height);
  ctx.translate(width / 2, height / 2);

  var color = hslToRgb(angle, 1, 0.5);

  ctx.fillStyle = `rgb(${color[0]},${color[1]},${color[2]})`;
  ctx.beginPath();
  ctx.arc(0, 0, radius * 0.3, 0, Math.PI * 2, true);
  ctx.closePath();
  ctx.fill();
  ctx.rotate((angle * 360) * Math.PI / 180);

  ctx.beginPath()
  ctx.setLineWidth(height * 0.015);
  //圆心的 x 坐标  , 圆心的 Y 坐标 , 圆的半径
  ctx.arc(height * 0.41, 0, 17, 0, 2 * Math.PI);

  const grd = ctx.createCircularGradient(height * 0.41, 0, 17)
  grd.addColorStop(0, '#fff');
  grd.addColorStop(0.2, '#fff');
  grd.addColorStop(.7, '#bfbfbf');
  grd.addColorStop(1, '#666');

  // Fill with gradient
  ctx.setFillStyle(grd);
  ctx.fill();
  // ctx.strokeStyle = 'rgb(255, 255, 255)';
  // ctx.stroke()

  ctx.draw();
  ctx.restore();
};


module.exports = {
  rgb2hsl: rgb2hsl,
  hslToRgb: hslToRgb,
  drawRing: drawRing,
  drawSlider: drawSlider,
}