<template>
  <div style="padding-left: 20px">
    <el-row :gutter="120">
      <el-col :xs="24" :sm="24" :md="24" :lg="14" :xl="10" style="margin-bottom: 50px">
        <el-descriptions :column="1" border style="margin-bottom: 50px">
          <!-- 设备模式-->
          <el-descriptions-item :labelStyle="statusColor">
            <template slot="label">
              <i class="el-icon-menu"></i>
              设备模式
            </template>
            <el-link :underline="false" style="line-height: 28px; font-size: 16px; padding-right: 10px">{{ title }}</el-link>
          </el-descriptions-item>

          <!-- 设备物模型-->
          <el-descriptions-item v-for="(item, index) in deviceInfo.thingsModels" :key="index" :labelStyle="statusColor">
            <template slot="label">
              <i class="el-icon-open"></i>
              {{ item.name }}
            </template>
            <div v-if="item.datatype.type == 'bool'">
              <el-switch
                v-model="item.shadow"
                @change="mqttPublish(deviceInfo, item)"
                active-text=""
                inactive-text=""
                active-value="1"
                inactive-value="0"
                style="min-width: 100px"
                :disabled="shadowUnEnable || item.isReadonly == 1"
              />
            </div>
            <div v-if="item.datatype.type == 'enum'">
              <div v-if="item.datatype.showWay && item.datatype.showWay == 'button'">
                <el-button
                  style="margin: 5px"
                  size="mini"
                  @click="enumButtonClick(deviceInfo, item, subItem.value)"
                  v-for="subItem in item.datatype.enumList"
                  :key="subItem.value"
                  :disabled="shadowUnEnable || item.isReadonly == 1"
                >
                  {{ subItem.text }}
                </el-button>
              </div>
              <el-select v-else v-model="item.shadow" placeholder="请选择" @change="mqttPublish(deviceInfo, item)" :disabled="shadowUnEnable || item.isReadonly == 1">
                <el-option v-for="subItem in item.datatype.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
              </el-select>
            </div>
            <div v-if="item.datatype.type == 'string'">
              <el-input v-model="item.shadow" :placeholder="'请输入字符串 ' + (item.datatype.unit ? '，单位：' + item.datatype.unit : '')" :disabled="shadowUnEnable || item.isReadonly == 1">
                <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, item)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable && item.isReadonly == 0"></el-button>
              </el-input>
            </div>
            <div v-if="item.datatype.type == 'decimal'">
              <div style="width: 80%; float: left">
                <el-slider
                  v-model="item.shadow"
                  :min="item.datatype.min"
                  :max="item.datatype.max"
                  :step="item.datatype.step"
                  :format-tooltip="(x) => x + ' ' + item.datatype.unit"
                  :disabled="shadowUnEnable || item.isReadonly == 1"
                ></el-slider>
              </div>
              <div style="width: 20%; float: left">
                <el-button
                  icon="el-icon-s-promotion"
                  type="info"
                  @click="mqttPublish(deviceInfo, item)"
                  style="font-size: 16px; padding: 1px 8px; margin: 2px 0 0 5px; border-radius: 3px"
                  title="指令发送"
                  v-if="!shadowUnEnable && item.isReadonly == 0"
                ></el-button>
              </div>
            </div>
            <div v-if="item.datatype.type == 'integer'">
              <div style="width: 80%; float: left">
                <el-slider
                  v-model="item.shadow"
                  :min="item.datatype.min"
                  :max="item.datatype.max"
                  :step="item.datatype.step"
                  :format-tooltip="(x) => x + ' ' + item.datatype.unit"
                  :disabled="shadowUnEnable || item.isReadonly == 1"
                ></el-slider>
              </div>
              <div style="width: 20%; float: left">
                <el-button
                  icon="el-icon-s-promotion"
                  type="info"
                  @click="mqttPublish(deviceInfo, item)"
                  style="font-size: 16px; padding: 1px 8px; margin: 4px 0 0 10px; border-radius: 3px"
                  title="指令发送"
                  v-if="!shadowUnEnable && item.isReadonly == 0"
                ></el-button>
              </div>
            </div>
            <div v-if="item.datatype.type == 'object'">
              <el-descriptions :column="1" size="mini" border>
                <el-descriptions-item v-for="(param, index) in item.datatype.params" :key="index" :label="param.name">
                  <div v-if="param.datatype.type == 'bool'">
                    <el-switch
                      v-model="param.shadow"
                      @change="mqttPublish(deviceInfo, param)"
                      active-text=""
                      inactive-text=""
                      active-value="1"
                      inactive-value="0"
                      style="min-width: 100px"
                      :disabled="shadowUnEnable || param.isReadonly == 1"
                    />
                  </div>
                  <div v-if="param.datatype.type == 'enum'">
                    <div v-if="param.datatype.showWay && param.datatype.showWay == 'button'">
                      <el-button
                        style="margin: 5px"
                        size="mini"
                        @click="enumButtonClick(deviceInfo, param, subItem.value)"
                        v-for="subItem in param.datatype.enumList"
                        :key="subItem.value"
                        :disabled="shadowUnEnable || param.isReadonly == 1"
                      >
                        {{ subItem.text }}
                      </el-button>
                    </div>
                    <el-select size="small" v-else v-model="param.shadow" placeholder="请选择" @change="mqttPublish(deviceInfo, param)" :disabled="shadowUnEnable || param.isReadonly == 1">
                      <el-option v-for="subItem in param.datatype.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
                    </el-select>
                  </div>
                  <div v-if="param.datatype.type == 'string'">
                    <el-input v-model="param.shadow" placeholder="请输入字符串" :disabled="shadowUnEnable || param.isReadonly == 1">
                      <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, param)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable && param.isReadonly == 0"></el-button>
                    </el-input>
                  </div>
                  <div v-if="param.datatype.type == 'decimal'">
                    <el-input v-model="param.shadow" type="number" placeholder="请输入小数 " :disabled="shadowUnEnable || param.isReadonly == 1">
                      <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, param)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable && param.isReadonly == 0"></el-button>
                    </el-input>
                  </div>
                  <div v-if="param.datatype.type == 'integer'">
                    <el-input v-model="param.shadow" type="integer" placeholder="请输入整数 " :disabled="shadowUnEnable || param.isReadonly == 1">
                      <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, param)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable && param.isReadonly == 0"></el-button>
                    </el-input>
                  </div>
                </el-descriptions-item>
              </el-descriptions>
            </div>
            <div v-if="item.datatype.type == 'array'">
              <el-descriptions :column="1" size="mini" border v-if="item.datatype.arrayType != 'object'">
                <el-descriptions-item v-for="(model, index) in item.datatype.arrayModel" :key="index" :label="item.name + (index + 1)">
                  <div v-if="item.datatype.arrayType == 'string'">
                    <el-input placeholder="请输入字符串" size="mini" v-model="model.shadow" :disabled="shadowUnEnable || item.isReadonly == 1" @input="arrayItemChange($event, item)">
                      <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, model)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable || item.isReadonly == 0"></el-button>
                    </el-input>
                  </div>
                  <div v-if="item.datatype.arrayType == 'decimal'">
                    <el-input type="number" placeholder="请输入小数 " size="mini" v-model="model.shadow" :disabled="shadowUnEnable || item.isReadonly == 1" @input="arrayItemChange($event, item)">
                      <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, model)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable || item.isReadonly == 0"></el-button>
                    </el-input>
                  </div>
                  <div v-if="item.datatype.arrayType == 'integer'">
                    <el-input type="integer" placeholder="请输入整数 " size="mini" v-model="model.shadow" :disabled="shadowUnEnable || item.isReadonly == 1" @input="arrayItemChange($event, item)">
                      <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, model)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable || item.isReadonly == 0"></el-button>
                    </el-input>
                  </div>
                </el-descriptions-item>
              </el-descriptions>
              <el-collapse v-if="item.datatype.arrayType == 'object'">
                <el-collapse-item v-for="(arrayParam, index) in item.datatype.arrayParams" :key="index">
                  <template slot="title">
                    <span style="color: #666">
                      <i class="el-icon-tickets"></i>
                      {{ item.name + (index + 1) }}
                    </span>
                  </template>
                  <el-descriptions :column="1" size="mini" border>
                    <el-descriptions-item v-for="(param, index) in arrayParam" :key="index" :label="param.name">
                      <div v-if="param.datatype.type == 'bool'">
                        <el-switch
                          v-model="param.shadow"
                          @change="mqttPublish(deviceInfo, param)"
                          active-text=""
                          inactive-text=""
                          active-value="1"
                          inactive-value="0"
                          style="min-width: 100px"
                          :disabled="shadowUnEnable || param.isReadonly == 1"
                        />
                      </div>
                      <div v-if="param.datatype.type == 'enum'">
                        <div v-if="param.datatype.showWay && param.datatype.showWay == 'button'">
                          <el-button
                            style="margin: 5px"
                            size="mini"
                            @click="enumButtonClick(deviceInfo, param, subItem.value)"
                            v-for="subItem in param.datatype.enumList"
                            :key="subItem.value"
                            :disabled="shadowUnEnable || param.isReadonly == 1"
                          >
                            {{ subItem.text }}
                          </el-button>
                        </div>
                        <el-select v-else v-model="param.shadow" placeholder="请选择" size="small" @change="mqttPublish(deviceInfo, param)" :disabled="shadowUnEnable || param.isReadonly == 1">
                          <el-option v-for="subItem in param.datatype.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
                        </el-select>
                      </div>
                      <div v-if="param.datatype.type == 'string'">
                        <el-input v-model="param.shadow" placeholder="请输入字符串" :disabled="shadowUnEnable || param.isReadonly == 1">
                          <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, param)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable && param.isReadonly == 0"></el-button>
                        </el-input>
                      </div>
                      <div v-if="param.datatype.type == 'decimal'">
                        <el-input v-model="param.shadow" type="number" placeholder="请输入小数 " :disabled="shadowUnEnable || param.isReadonly == 1">
                          <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, param)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable && param.isReadonly == 0"></el-button>
                        </el-input>
                      </div>
                      <div v-if="param.datatype.type == 'integer'">
                        <el-input v-model="param.shadow" type="integer" placeholder="请输入整数 " :disabled="shadowUnEnable || param.isReadonly == 1">
                          <el-button slot="append" icon="el-icon-s-promotion" @click="mqttPublish(deviceInfo, param)" style="font-size: 20px" title="指令发送" v-if="!shadowUnEnable && param.isReadonly == 0"></el-button>
                        </el-input>
                      </div>
                    </el-descriptions-item>
                  </el-descriptions>
                </el-collapse-item>
              </el-collapse>
            </div>
          </el-descriptions-item>
        </el-descriptions>

        <!---设备状态(影子模式，value值不会更新)-->
        <el-descriptions :column="1" border size="mini" v-if="deviceInfo.isShadow == 1 && deviceInfo.status != 3">
          <template slot="title">
            <span style="font-size: 14px; color: #606266">设备离线时状态</span>
          </template>

          <!-- 设备物模型-->
          <el-descriptions-item v-for="(item, index) in deviceInfo.thingsModels" :key="index">
            <template slot="label">
              <i class="el-icon-open"></i>
              {{ item.name }}
            </template>
            <div v-if="item.datatype.type == 'bool'">
              <el-switch v-model="item.value" @change="mqttPublish(deviceInfo, item)" active-text="" inactive-text="" active-value="1" inactive-value="0" style="min-width: 100px" disabled />
            </div>
            <div v-if="item.datatype.type == 'enum'">
              <div v-if="item.datatype.showWay && item.datatype.showWay == 'button'">
                <el-button style="margin: 5px" size="mini" disabled v-for="subItem in item.datatype.enumList" :key="subItem.value">{{ subItem.text }}</el-button>
              </div>
              <el-select v-else v-model="item.value" placeholder="请选择" @change="mqttPublish(deviceInfo, item)" disabled size="mini">
                <el-option v-for="subItem in item.datatype.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
              </el-select>
            </div>
            <div v-if="item.datatype.type == 'string'">
              <el-input v-model="item.value" placeholder="请输入字符串" disabled size="mini"></el-input>
            </div>
            <div v-if="item.datatype.type == 'decimal'">
              <el-input v-model="item.value" type="number" placeholder="请输入小数 " disabled size="mini"></el-input>
            </div>
            <div v-if="item.datatype.type == 'integer'">
              <el-input v-model="item.value" type="integer" placeholder="请输入整数 " disabled size="mini"></el-input>
            </div>
            <div v-if="item.datatype.type == 'object'">
              <el-descriptions :column="1" size="mini" border>
                <el-descriptions-item v-for="(param, index) in item.datatype.params" :key="index" :label="param.name">
                  <div v-if="param.datatype.type == 'bool'">
                    <el-switch v-model="param.value" size="mini" @change="mqttPublish(deviceInfo, param)" active-text="" inactive-text="" active-value="1" inactive-value="0" style="min-width: 100px" disabled />
                  </div>
                  <div v-if="param.datatype.type == 'enum'">
                    <el-select v-model="param.value" placeholder="请选择" @change="mqttPublish(deviceInfo, param)" disabled size="mini">
                      <el-option v-for="subItem in param.datatype.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
                    </el-select>
                  </div>
                  <div v-if="param.datatype.type == 'string'">
                    <el-input v-model="param.value" placeholder="请输入字符串" disabled size="mini"></el-input>
                  </div>
                  <div v-if="param.datatype.type == 'decimal'">
                    <el-input v-model="param.value" type="number" placeholder="请输入小数 " disabled size="mini"></el-input>
                  </div>
                  <div v-if="param.datatype.type == 'integer'">
                    <el-input v-model="param.value" type="integer" placeholder="请输入整数 " disabled size="mini"></el-input>
                  </div>
                </el-descriptions-item>
              </el-descriptions>
            </div>
            <div v-if="item.datatype.type == 'array'">
              <el-descriptions :column="1" size="mini" border v-if="item.datatype.arrayType != 'object'">
                <el-descriptions-item v-for="(model, index) in item.datatype.arrayModel" :key="index" :label="item.name + (index + 1)">
                  <div v-if="item.datatype.arrayType == 'string'">
                    <el-input v-model="model.value" placeholder="请输入字符串" size="mini" disabled></el-input>
                  </div>
                  <div v-if="item.datatype.arrayType == 'decimal'">
                    <el-input v-model="model.value" type="number" placeholder="请输入小数 " size="mini" disabled></el-input>
                  </div>
                  <div v-if="item.datatype.arrayType == 'integer'">
                    <el-input v-model="model.value" type="integer" placeholder="请输入整数 " size="mini" disabled></el-input>
                  </div>
                </el-descriptions-item>
              </el-descriptions>
              <el-collapse v-if="item.datatype.arrayType == 'object'">
                <el-collapse-item v-for="(arrayParam, index) in item.datatype.arrayParams" :key="index">
                  <template slot="title">
                    <span style="color: #666">
                      <i class="el-icon-tickets"></i>
                      {{ item.name + (index + 1) }}
                    </span>
                  </template>
                  <el-descriptions :column="1" size="mini" border>
                    <el-descriptions-item v-for="(param, index) in arrayParam" :key="index" :label="param.name">
                      <div v-if="param.datatype.type == 'bool'">
                        <el-switch v-model="param.value" @change="mqttPublish(deviceInfo, param)" active-text="" inactive-text="" active-value="1" inactive-value="0" style="min-width: 100px" disabled />
                      </div>
                      <div v-if="param.datatype.type == 'enum'">
                        <el-select v-model="param.value" placeholder="请选择" @change="mqttPublish(deviceInfo, param)" disabled size="mini">
                          <el-option v-for="subItem in param.datatype.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
                        </el-select>
                      </div>
                      <div v-if="param.datatype.type == 'string'">
                        <el-input v-model="param.value" placeholder="请输入字符串" disabled size="mini"></el-input>
                      </div>
                      <div v-if="param.datatype.type == 'decimal'">
                        <el-input v-model="param.value" type="number" placeholder="请输入小数 " disabled size="mini"></el-input>
                      </div>
                      <div v-if="param.datatype.type == 'integer'">
                        <el-input v-model="param.value" type="integer" placeholder="请输入整数 " disabled size="mini"></el-input>
                      </div>
                    </el-descriptions-item>
                  </el-descriptions>
                </el-collapse-item>
              </el-collapse>
            </div>
          </el-descriptions-item>
        </el-descriptions>
      </el-col>

      <el-col :xs="24" :sm="24" :md="24" :lg="10" :xl="14">
        <!-- 设备监测图表-->
        <el-row :gutter="20" style="background-color: #f5f7fa; padding: 20px 10px 20px 10px; border-radius: 15px; margin-right: 5px" v-if="deviceInfo.chartList.length > 0">
          <el-col :xs="24" :sm="12" :md="12" :lg="24" :xl="8" v-for="(item, index) in deviceInfo.chartList" :key="index">
            <el-card shadow="hover" style="border-radius: 30px; margin-bottom: 20px">
              <div ref="map" style="height: 230px; width: 185px; margin: 0 auto"></div>
            </el-card>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
  </div>
</template>

<script>

import { serviceInvoke } from '@/api/iot/runstatus';

export default {
  name: 'running-status',
  props: {
    device: {
      type: Object,
      default: null,
    },
  },
  watch: {
    // 获取到父组件传递的device后，刷新列表
    device: function (newVal, oldVal) {
      if (newVal && newVal.deviceId != 0) {
        this.deviceInfo = newVal;
        this.updateDeviceStatus(this.deviceInfo);
        this.$nextTick(function () {
          this.MonitorChart();
        });
        this.mqttCallback();
      }
    },
  },
  data() {
    return {
      // 控制模块标题
      title: '设备控制 ',
      // 未启用设备影子
      shadowUnEnable: false,
      // 控制项标题背景
      statusColor: {
        background: '#67C23A',
        color: '#fff',
        minWidth: '100px',
      },
      // 最新固件信息
      firmware: {},
      // 打开固件对话框
      openFirmware: false,
      // 遮罩层
      loading: true,
      // 设备信息
      deviceInfo: {
        boolList: [],
        enumList: [],
        stringList: [],
        integerList: [],
        decimalList: [],
        arrayList: [],
        thingsModels: [],
        chartList: [],
      },
      // 监测图表
      monitorChart: [
        {
          chart: {},
          data: {
            id: '',
            name: '',
            value: '',
          },
        },
      ],
      remoteCommand: {},
    };
  },
  created() {},
  methods: {
    /* Mqtt回调处理 */
    mqttCallback() {
      this.$mqttTool.client.on('message', (topic, message, buffer) => {
        let topics = topic.split('/');
        let productId = topics[1];
        let deviceNum = topics[2];
        message = JSON.parse(message.toString());
        if (!message) {
          return;
        }
        if (topics[3] == 'status') {
          console.log('接收到【设备状态-运行】主题：', topic);
          console.log('接收到【设备状态-运行】内容：', message);
          // 更新列表中设备的状态
          if (this.deviceInfo.serialNumber == deviceNum) {
            this.deviceInfo.status = message.status;
            this.deviceInfo.isShadow = message.isShadow;
            this.deviceInfo.rssi = message.rssi;
            this.updateDeviceStatus(this.deviceInfo);
          }
        }
        //兼容设备回复
        if (topics[4] == 'reply') {
          this.$modal.notifySuccess(message);
        }
        if (topic.endsWith('ws/service')) {
          console.log('接收到【物模型】主题1：', topic);
          console.log('接收到【物模型】内容：', message);
          // 更新列表中设备的属性
          if (this.deviceInfo.serialNumber == deviceNum) {
            for (let j = 0; j < message.length; j++) {
              let isComplete = false;
              // 设备状态
              for (let k = 0; k < this.deviceInfo.thingsModels.length && !isComplete; k++) {
                if (this.deviceInfo.thingsModels[k].id == message[j].id) {
                  // 普通类型(小数/整数/字符串/布尔/枚举)
                  if (this.deviceInfo.thingsModels[k].datatype.type == 'decimal' || this.deviceInfo.thingsModels[k].datatype.type == 'integer') {
                    this.deviceInfo.thingsModels[k].shadow = Number(message[j].value);
                  } else {
                    this.deviceInfo.thingsModels[k].shadow = message[j].value;
                  }
                  isComplete = true;
                  break;
                } else if (this.deviceInfo.thingsModels[k].datatype.type == 'object') {
                  // 对象类型
                  for (let n = 0; n < this.deviceInfo.thingsModels[k].datatype.params.length; n++) {
                    if (this.deviceInfo.thingsModels[k].datatype.params[n].id == message[j].id) {
                      this.deviceInfo.thingsModels[k].datatype.params[n].shadow = message[j].value;
                      isComplete = true;
                      break;
                    }
                  }
                } else if (this.deviceInfo.thingsModels[k].datatype.type == 'array') {
                  // 数组类型
                  if (this.deviceInfo.thingsModels[k].datatype.arrayType == 'object') {
                    // 1.对象类型数组,id为数组中一个元素,例如：array_01_gateway_temperature
                    if (String(message[j].id).indexOf('array_') == 0) {
                      for (let n = 0; n < this.deviceInfo.thingsModels[k].datatype.arrayParams.length; n++) {
                        for (let m = 0; m < this.deviceInfo.thingsModels[k].datatype.arrayParams[n].length; m++) {
                          if (this.deviceInfo.thingsModels[k].datatype.arrayParams[n][m].id == message[j].id) {
                            this.deviceInfo.thingsModels[k].datatype.arrayParams[n][m].shadow = message[j].value;
                            isComplete = true;
                            break;
                          }
                        }
                        if (isComplete) {
                          break;
                        }
                      }
                    } else {
                      // 2.对象类型数组，例如：gateway_temperature,消息ID添加前缀后匹配
                      for (let n = 0; n < this.deviceInfo.thingsModels[k].datatype.arrayParams.length; n++) {
                        for (let m = 0; m < this.deviceInfo.thingsModels[k].datatype.arrayParams[n].length; m++) {
                          let index = n > 9 ? String(n) : '0' + k;
                          let prefix = 'array_' + index + '_';
                          if (this.deviceInfo.thingsModels[k].datatype.arrayParams[n][m].id == prefix + message[j].id) {
                            this.deviceInfo.thingsModels[k].datatype.arrayParams[n][m].shadow = message[j].value;
                            isComplete = true;
                          }
                        }
                        if (isComplete) {
                          break;
                        }
                      }
                    }
                  } else {
                    // 整数、小数和字符串类型数组
                    for (let n = 0; n < this.deviceInfo.thingsModels[k].datatype.arrayModel.length; n++) {
                      if (this.deviceInfo.thingsModels[k].datatype.arrayModel[n].id == message[j].id) {
                        this.deviceInfo.thingsModels[k].datatype.arrayModel[n].shadow = message[j].value;
                        isComplete = true;
                        break;
                      }
                    }
                  }
                }
              }
              // 图表数据
              for (let k = 0; k < this.deviceInfo.chartList.length; k++) {
                if (this.deviceInfo.chartList[k].id.indexOf('array_') == 0) {
                  // 数组类型匹配,例如：array_00_gateway_temperature
                  if (this.deviceInfo.chartList[k].id == message[j].id) {
                    // let shadows = message[j].value.split(",");
                    this.deviceInfo.chartList[k].shadow = message[j].value;
                    // 更新图表
                    for (let m = 0; m < this.monitorChart.length; m++) {
                      if (message[j].id == this.monitorChart[m].data.id) {
                        let data = [
                          {
                            value: message[j].value,
                            name: this.monitorChart[m].data.name,
                          },
                        ];
                        this.monitorChart[m].chart.setOption({
                          series: [
                            {
                              data: data,
                            },
                          ],
                        });
                        break;
                      }
                    }
                  }
                } else {
                  // 普通类型匹配
                  if (this.deviceInfo.chartList[k].id == message[j].id) {
                    this.deviceInfo.chartList[k].shadow = message[j].value;
                    // 更新图表
                    for (let m = 0; m < this.monitorChart.length; m++) {
                      if (message[j].id == this.monitorChart[m].data.id) {
                        isComplete = true;
                        let data = [
                          {
                            value: message[j].value,
                            name: this.monitorChart[m].data.name,
                          },
                        ];
                        this.monitorChart[m].chart.setOption({
                          series: [
                            {
                              data: data,
                            },
                          ],
                        });
                        break;
                      }
                    }
                  }
                }
                if (isComplete) {
                  break;
                }
              }
            }
          }
        }
      });
    },

    //发送指令
    mqttPublish(device, model) {
      const command = {};
      command[model.id] = model.shadow;
      const data = {
        serialNumber: device.serialNumber,
        productId: device.productId,
        remoteCommand: command,
        identifier: model.id,
        modelName: model.name,
        isShadow: device.status != 3,
        type: model.type,
      };
      serviceInvoke(data).then((response) => {
        if (response.code === 200) {
          this.$message({
            type: 'success',
            message: '服务调用成功!',
          });
        }
      });
    },

    /**
     * Mqtt发布消息
     * @device 设备
     * @model 物模型(id/name/type/name/isReadonly/value/shadow)，type 类型(1=属性，2=功能，3=OTA升级，4=实时监测)
     * */
    // mqttPublish(device, model) {
    //     let topic = "";
    //     let message = ""
    //     if (model.type == 1) {
    //         if (device.status == 3) {
    //             // 属性,在线模式
    //             topic = "/" + device.productId + "/" + device.serialNumber + "/property-online/get";
    //         } else if (device.isShadow) {
    //             // 属性,离线模式
    //             topic = "/" + device.productId + "/" + device.serialNumber + "/property-offline/post";
    //         }
    //         message = '[{"id":"' + model.id + '","value":"' + model.shadow + '"}]';
    //     } else if (model.type == 2) {
    //         if (device.status == 3) {
    //             // 功能,在线模式
    //             topic = "/" + device.productId + "/" + device.serialNumber + "/function-online/get";
    //
    //         } else if (device.isShadow) {
    //             // 功能,离线模式
    //             topic = "/" + device.productId + "/" + device.serialNumber + "/function-offline/post";
    //         }
    //         message = '[{"id":"' + model.id + '","value":"' + model.shadow + '"}]';
    //     } else if (model.type == 3) {
    //         // OTA升级
    //         topic = "/" + device.productId + "/" + device.serialNumber + "/ota/get";
    //         message = '{"version":' + this.firmware.version + ',"downloadUrl":"' + this.getDownloadUrl(this.firmware.filePath) + '"}';
    //     } else {
    //         return;
    //     }
    //     if (topic != "") {
    //         // 发布
    //         this.$mqttTool.publish(topic, message, model.name).then(res => {
    //             this.$modal.notifySuccess(res);
    //         }).catch(res => {
    //             this.$modal.notifyError(res);
    //         });
    //     }
    // },

    /** 枚举类型按钮单击 */
    enumButtonClick(device, model, value) {
      model.shadow = value;
      this.mqttPublish(device, model);
    },

    /** 更新设备状态 */
    updateDeviceStatus(device) {
      if (device.status == 3) {
        this.statusColor.background = '#12d09f';
        this.title = '在线模式';
      } else {
        if (device.isShadow == 1) {
          this.statusColor.background = '#409EFF';
          this.title = '影子模式';
        } else {
          this.statusColor.background = '#909399';
          this.title = '离线模式';
          this.shadowUnEnable = true;
        }
      }
      this.$emit('statusEvent', this.deviceInfo.status);
    },
    /** 物模型数组元素值改变事件 */
    arrayItemChange(value, thingsModel) {
      let shadow = '';
      for (let i = 0; i < thingsModel.datatype.arrayCount; i++) {
        shadow += thingsModel.datatype.arrayModel[i].shadow + ',';
      }
      shadow = shadow.substring(0, shadow.length - 1);
      thingsModel.shadow = shadow;
    },
    /** 物模型中数组值改变事件 */
    arrayInputChange(value, thingsModel) {
      let arrayModels = value.split(',');
      if (arrayModels.length != thingsModel.datatype.arrayCount) {
        this.$modal.alertWarning('元素个数不匹配，数组元素个数为' + thingsModel.datatype.arrayCount + '个，以英文逗号分隔。');
      } else {
        for (let i = 0; i < thingsModel.datatype.arrayCount; i++) {
          thingsModel.datatype.arrayModel[i].shadow = arrayModels[i];
        }
      }
    },
    /**用户是否拥有分享设备权限*/
    hasShrarePerm(permission) {
      if (this.deviceInfo.isOwner == 0) {
        // 分享设备权限
        if (this.deviceInfo.userPerms.indexOf(permission) == -1) {
          return false;
        }
      }
      return true;
    },
    /** 设备升级 */
    otaUpgrade() {
      // OTA升级
      let topic = '/' + this.deviceInfo.productId + '/' + this.deviceInfo.serialNumber + '/ota/get';
      let message = '{"version":' + this.firmware.version + ',"downloadUrl":"' + this.getDownloadUrl(this.firmware.filePath) + '"}';
      // 发布
      this.$mqttTool
        .publish(topic, message, '设备升级')
        .then((res) => {
          this.$modal.notifySuccess(res);
        })
        .catch((res) => {
          this.$modal.notifyError(res);
        });
      this.openFirmware = false;
    },
    /** 获取最新固件 */
    getLatestFirmware(deviceId) {
      getLatestFirmware(deviceId).then((response) => {
        this.firmware = response.data;
        this.openFirmware = true;
      });
    },
    // 取消按钮
    cancel() {
      this.openFirmware = false;
    },
    // 获取下载路径前缀
    getDownloadUrl(path) {
      return window.location.origin + process.env.VUE_APP_BASE_API + path;
    },
    /**图表展示*/
    MonitorChart() {
      for (let i = 0; i < this.deviceInfo.chartList.length; i++) {
        this.monitorChart[i] = {
          chart: this.$echarts.init(this.$refs.map[i]),
          data: {
            id: this.deviceInfo.chartList[i].id,
            name: this.deviceInfo.chartList[i].name,
            value: this.deviceInfo.chartList[i].shadow ? this.deviceInfo.chartList[i].shadow : this.deviceInfo.chartList[i].datatype.min,
          },
        };
        var option;
        option = {
          tooltip: {
            formatter: ' {b} <br/> {c}' + this.deviceInfo.chartList[i].datatype.unit,
          },
          series: [
            {
              name: this.deviceInfo.chartList[i].datatype.type,
              type: 'gauge',
              min: this.deviceInfo.chartList[i].datatype.min,
              max: this.deviceInfo.chartList[i].datatype.max,
              colorBy: 'data',
              splitNumber: 10,
              radius: '100%',
              // 分割线
              splitLine: {
                distance: 4,
              },
              axisLabel: {
                fontSize: 10,
                distance: 10,
              },
              // 刻度线
              axisTick: {
                distance: 4,
              },
              // 仪表盘轴线
              axisLine: {
                lineStyle: {
                  width: 8,
                  color: [
                    [0.2, '#409EFF'], // 0~20%
                    [0.8, '#12d09f'], // 40~60%
                    [1, '#F56C6C'], // 80~100%
                  ],
                  opacity: 0.3,
                },
              },
              pointer: {
                icon: 'triangle',
                length: '60%',
                width: 7,
              },
              progress: {
                show: true,
                width: 8,
              },
              detail: {
                valueAnimation: true,
                formatter: '{value}' + ' ' + this.deviceInfo.chartList[i].datatype.unit,
                offsetCenter: [0, '80%'],
                fontSize: 20,
              },
              data: [
                {
                  value: this.deviceInfo.chartList[i].shadow ? this.deviceInfo.chartList[i].shadow : this.deviceInfo.chartList[i].datatype.min,
                  name: this.deviceInfo.chartList[i].name,
                },
              ],
              title: {
                offsetCenter: [0, '115%'],
                fontSize: 16,
              },
            },
          ],
        };
        option && this.monitorChart[i].chart.setOption(option);
      }
    },
  },
};
</script>

<style>
/* 重写滑动块样式 */
.el-slider__bar {
  height: 18px;
}

.el-slider__runway {
  height: 18px;
  margin: 5px 0;
}

.el-slider__button {
  height: 18px;
  width: 18px;
  border-radius: 10%;
}

.el-slider__button-wrapper {
  top: -9px;
}
</style>
