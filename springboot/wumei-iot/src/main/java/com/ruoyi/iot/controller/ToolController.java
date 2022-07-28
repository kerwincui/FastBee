package com.ruoyi.iot.controller;

import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.file.FileNameLengthLimitExceededException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.domain.ProductAuthorize;
import com.ruoyi.iot.mapper.ProductAuthorizeMapper;
import com.ruoyi.iot.model.*;
import com.ruoyi.iot.model.ThingsModels.ThingsModelShadow;
import com.ruoyi.iot.mqtt.EmqxService;
import com.ruoyi.iot.mqtt.MqttConfig;
import com.ruoyi.iot.service.IDeviceService;
import com.ruoyi.iot.service.IProductAuthorizeService;
import com.ruoyi.iot.service.IToolService;
import com.ruoyi.iot.service.impl.ThingsModelServiceImpl;
import com.ruoyi.iot.util.AESUtils;
import com.ruoyi.iot.util.VelocityInitializer;
import com.ruoyi.iot.util.VelocityUtils;
import com.ruoyi.system.service.ISysUserService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.io.IOUtils;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import static com.ruoyi.common.utils.file.FileUploadUtils.getExtension;

/**
 * 产品分类Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "工具相关")
@RestController
@RequestMapping("/iot/tool")
public class ToolController extends BaseController {
    private static final Logger log = LoggerFactory.getLogger(ToolController.class);

    @Autowired
    private IDeviceService deviceService;

    @Lazy
    @Autowired
    private EmqxService emqxService;

    @Autowired
    private MqttConfig mqttConfig;

    @Autowired
    private IToolService toolService;

    // 令牌秘钥
    @Value("${token.secret}")
    private String secret;

    @Autowired
    private RedisCache redisCache;

    /**
     * 用户注册
     */
    @ApiOperation("用户注册")
    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterUserInput user) {
        String msg = toolService.register(user);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }

    /**
     * 获取用户列表
     */
    @GetMapping("/userList")
    public TableDataInfo list(SysUser user)
    {
        startPage();
        List<SysUser> list = toolService.selectUserList(user);
        return getDataTable(list);
    }

    @ApiOperation("mqtt认证")
    @PostMapping("/mqtt/auth")
    public ResponseEntity mqttAuth(@RequestParam String clientid, @RequestParam String username, @RequestParam String password) throws Exception {
        if (clientid.startsWith("server")) {
            // 服务端认证：配置的账号密码认证
            if (mqttConfig.getusername().equals(username) && mqttConfig.getpassword().equals(password)) {
                log.info("-----------服务端mqtt认证成功,clientId:" + clientid + "---------------");
                return ResponseEntity.ok().body("ok");
            } else {
                return toolService.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "mqtt账号和密码与认证服务器配置不匹配");
            }
        } else if (clientid.startsWith("web") || clientid.startsWith("phone")) {
            // web端和移动端认证：token认证
            String token = password;
            if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
                token = token.replace(Constants.TOKEN_PREFIX, "");
            }
            try {
                Claims claims = Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
                log.info("-----------移动端/Web端mqtt认证成功,clientId:" + clientid + "---------------");
                return ResponseEntity.ok().body("ok");
            } catch (Exception ex) {
                return toolService.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), ex.getMessage());
            }
        } else {
            // 设备端认证：加密认证（E）和简单认证（S，配置的账号密码认证）
            String[] clientArray = clientid.split("&");
            if(clientArray.length != 4 || clientArray[0].equals("") || clientArray[1].equals("") || clientArray[2].equals("") || clientArray[3].equals("")){
                return toolService.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备mqtt客户端Id格式为：认证类型 & 设备编号 & 产品ID & 用户ID");
            }
            String authType = clientArray[0];
            String deviceNumber = clientArray[1];
            Long productId = Long.valueOf(clientArray[2]);
            Long userId = Long.valueOf(clientArray[3]);
            // 产品认证信息
            ProductAuthenticateModel model = deviceService.selectProductAuthenticate(new AuthenticateInputModel(deviceNumber, productId));
            if (model == null) {
                return toolService.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备认证，通过产品ID查询不到信息");
            }
            if (model.getProductStatus() != 2) {
                // 产品必须为发布状态：1-未发布，2-已发布
                return toolService.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备认证，设备对应产品还未发布");
            }

            if (authType.equals("S")) {
                // 设备简单认证
                return toolService.simpleMqttAuthentication(new MqttAuthenticationModel(clientid, username, password, deviceNumber, productId, userId), model);

            } else if (authType.equals("E")) {
                // 设备加密认证
                return toolService.encryptAuthentication(new MqttAuthenticationModel(clientid, username, password, deviceNumber, productId, userId), model);
            } else {
                return toolService.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备认证，认证类型有误");
            }
        }
    }


    @ApiOperation("mqtt钩子处理")
    @PostMapping("/mqtt/webhook")
    public void webHookProcess(@RequestBody MqttClientConnectModel model) {
        try {
            System.out.println("webhook:" + model.getAction());
            // 过滤服务端、web端和手机端
            if (model.getClientid().startsWith("server") || model.getClientid().startsWith("web") || model.getClientid().startsWith("phone")) {
                return;
            }
            // 设备端认证：加密认证（E）和简单认证（S，配置的账号密码认证）
            String[] clientArray = model.getClientid().split("&");
            String authType = clientArray[0];
            String deviceNumber = clientArray[1];
            Long productId = Long.valueOf(clientArray[2]);
            Long userId = Long.valueOf(clientArray[3]);

            Device device = deviceService.selectShortDeviceBySerialNumber(deviceNumber);
            // 设备状态（1-未激活，2-禁用，3-在线，4-离线）
            if (model.getAction().equals("client_disconnected")) {
                device.setStatus(4);
                deviceService.updateDeviceStatusAndLocation(device, "");
                // 设备掉线后发布设备状态
                emqxService.publishStatus(device.getProductId(), device.getSerialNumber(), 4, device.getIsShadow(),device.getRssi());
                // 清空保留消息，上线后发布新的属性功能保留消息
                emqxService.publishProperty(device.getProductId(), device.getSerialNumber(), null);
                emqxService.publishFunction(device.getProductId(), device.getSerialNumber(), null);
            } else if (model.getAction().equals("client_connected")) {
                device.setStatus(3);
                deviceService.updateDeviceStatusAndLocation(device, model.getIpaddress());
                // 影子模式，发布属性和功能
                if (device.getIsShadow() == 1) {
                    ThingsModelShadow shadow = deviceService.getDeviceShadowThingsModel(device);
                    if (shadow.getProperties().size() > 0) {
                        emqxService.publishProperty(device.getProductId(), device.getSerialNumber(), shadow.getProperties());
                    }
                    if (shadow.getFunctions().size() > 0) {
                        emqxService.publishFunction(device.getProductId(), device.getSerialNumber(), shadow.getFunctions());
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            log.error("发生错误：" + ex.getMessage());
        }
    }


    @ApiOperation("获取NTP时间")
    @GetMapping("/ntp")
    public JSONObject ntp(@RequestParam Long deviceSendTime) {
        JSONObject ntpJson = new JSONObject();
        ntpJson.put("deviceSendTime", deviceSendTime);
        ntpJson.put("serverRecvTime", System.currentTimeMillis());
        ntpJson.put("serverSendTime", System.currentTimeMillis());
        return ntpJson;
    }

    /**
     * 文件上传
     */
    @PostMapping("/upload")
    @ApiOperation("文件上传")
    public AjaxResult uploadFile(MultipartFile file) throws Exception {
        try {
            String filePath = RuoYiConfig.getProfile();
            // 文件名长度限制
            int fileNamelength = file.getOriginalFilename().length();
            if (fileNamelength > FileUploadUtils.DEFAULT_FILE_NAME_LENGTH) {
                throw new FileNameLengthLimitExceededException(FileUploadUtils.DEFAULT_FILE_NAME_LENGTH);
            }
            // 文件类型限制
            // assertAllowed(file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);

            // 获取文件名和文件类型
            String fileName = file.getOriginalFilename();
            String extension = getExtension(file);
            //设置日期格式
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MMdd-HHmmss");
            fileName = "/iot/" + getLoginUser().getUserId().toString() + "/" + df.format(new Date()) + "." + extension;
            //创建目录
            File desc = new File(filePath + File.separator + fileName);
            if (!desc.exists()) {
                if (!desc.getParentFile().exists()) {
                    desc.getParentFile().mkdirs();
                }
            }
            // 存储文件
            file.transferTo(desc);

            String url = "/profile" + fileName;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("fileName", url);
            ajax.put("url", url);
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 下载文件
     */
    @ApiOperation("文件下载")
    @GetMapping("/download")
    public void download(String fileName, HttpServletResponse response, HttpServletRequest request) {
        try {
//            if (!FileUtils.checkAllowDownload(fileName)) {
//                throw new Exception(StringUtils.format("文件名称({})非法，不允许下载。 ", fileName));
//            }
            String filePath = RuoYiConfig.getProfile();
            // 资源地址
            String downloadPath = filePath + fileName.replace("/profile", "");
            // 下载名称
            String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, downloadName);
            FileUtils.writeBytes(downloadPath, response.getOutputStream());
        } catch (Exception e) {
            log.error("下载文件失败", e);
        }
    }

    /**
     * 批量生成代码
     */
    @Log(title = "SDK生成", businessType = BusinessType.GENCODE)
    @GetMapping("/genSdk")
    @ApiOperation("生成SDK")
    public void genSdk(HttpServletResponse response, int deviceChip) throws IOException {
        byte[] data = downloadCode(deviceChip);
        genSdk(response, data);
    }

    /**
     * 生成zip文件
     */
    private void genSdk(HttpServletResponse response, byte[] data) throws IOException {
        response.reset();
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Expose-Headers", "Content-Disposition");
        response.setHeader("Content-Disposition", "attachment; filename=\"ruoyi.zip\"");
        response.addHeader("Content-Length", "" + data.length);
        response.setContentType("application/octet-stream; charset=UTF-8");
        IOUtils.write(data, response.getOutputStream());
    }

    /**
     * 批量生成代码（下载方式）
     *
     * @param deviceChip
     * @return 数据
     */
    public byte[] downloadCode(int deviceChip) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(outputStream);
//        generatorCode(deviceChip, zip);
        IOUtils.closeQuietly(zip);
        return outputStream.toByteArray();
    }

    /**
     * 查询表信息并生成代码
     */
    private void generatorCode(int deviceChip, ZipOutputStream zip) {
        VelocityInitializer.initVelocity();

        VelocityContext context = VelocityUtils.prepareContext(deviceChip);

        // 获取模板列表
        List<String> templates = VelocityUtils.getTemplateList("");
        for (String template : templates) {
            // 渲染模板
            StringWriter sw = new StringWriter();
            Template tpl = Velocity.getTemplate(template, Constants.UTF8);
            tpl.merge(context, sw);
            try {
                // 添加到zip
                zip.putNextEntry(new ZipEntry(VelocityUtils.getFileName(template)));
                IOUtils.write(sw.toString(), zip, Constants.UTF8);
                IOUtils.closeQuietly(sw);
                zip.flush();
                zip.closeEntry();
            } catch (IOException e) {
                System.out.println("渲染模板失败");
            }
        }
    }

}
