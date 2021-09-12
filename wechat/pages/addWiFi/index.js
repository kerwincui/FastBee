const alreadyConnected = 'target wifi is already connected.';

Page({
    data: {
        pwdHide:true,
        ssid: '',
        password: '',
        deviceSSID:'Shgf',
        devicePWD:'12345678',
        // deviceSSID:'XiaoYi_IOT_AirBox',
        // devicePWD:'asdqwe9867',
        udp: '',
        port: 0,
        showClearBtn: false,
        isFirst: true,
        stepsTop: [
          { text: '步骤一',desc: '连接WiFi', },
          { text: '步骤二',desc: '连接软热点', },
          { text: '步骤三',desc: '开始配网', }
        ],
        steps: [
          { text: '手机与设备通信成功',success:false },
          { text: '设备配网成功',success:false },
          { text: '切换回家庭WiFi',success:false }
        ],
        activeTop:0,
        active:-1
    },
    onLoad(opt) {
        let that = this; 
        try {
            let udp = this.data.udp;
            udp.offListening();
            udp.offMessage();
            udp.offClose();
            udp.close();
        } catch (error) {
            console.log(error);
        }   
        wx.startWifi({
            success(res) {
                console.log(res.errMsg, 'wifi初始化成功')
                that.getWifiInfo();
            },
            fail: function (res) {
                wx.showToast({
                    title: '请连接路由器!',
                    duration: 2000,
                    icon: 'none'
                })
            }
        })
    },
    getWifiInfo() {
        let that = this
        wx.getConnectedWifi({
            success(res) {
                console.log("getConnectedWifi ok:", JSON.stringify(res))
                if ('getConnectedWifi:ok' === res.errMsg) {
                    that.setData({
                        ssid: res.wifi.SSID,
                        bssid: res.wifi.BSSID
                    })
                } else {
                    wx.showToast({
                        title: '请连接路由器',
                        duration: 2000,
                        icon: 'none'
                    })
                }
            },
            fail(res) {
                wx.showToast({
                    title: '请连接路由器',
                    duration: 2000,
                    icon: 'none'
                })
            }
        })
    },
    onConfirm() {
        const that = this;
        console.log("ssid:", this.data.ssid, ",password:", this.data.password,',port:',this.data.port);
        that.udpConnect();
        if ((this.data.ssid.trim() === '') || (this.data.password.trim() === '')) {
            wx.showToast({
              title: '请输入完整',
              icon:'error'
            });
            return;
        }
        that.setData({ activeTop:++that.data.activeTop });
        // that.udpConnect();
    },

    udpConnect(){
        const udp = wx.createUDPSocket();
        udp.onListening(res => {
            console.log('正在监听...');
        })   
        const password = this.data.password;
        const ssid = this.data.ssid;
        
        let message = JSON.stringify({
            port,
            password,
            ssid
        }); 
        let port = udp.bind(50314);
        console.log(udp,udp.onListening,udp.send);
        console.log('port',port); 
        // setInterval(() => {
        //     udp.send({
        //         address:'255.255.255.255',
        //         port:8081,
        //         message
        //     });
        // }, 2000);    
        console.log(message);
        udp.onMessage((res) => {
            console.log('res:',res)
            //字符串转换，很重要
            let unit8Arr = new Uint8Array(res.message);
            let encodedString = String.fromCharCode.apply(null, unit8Arr);
            let dat = decodeURIComponent(escape((encodedString)));
            console.log("data:", dat);
            let str = JSON.parse(dat);
            console.log(str);
            switch (str.code) {
                //成功收到信息
                case 0:
                    udp.send({
                        address:'255.255.255.255',
                        port:8081,
                        message
                    });
                    let steps = this.data.steps;
                    steps[0].success = true;
                    this.setData({ steps });
                    break;
                    //成功解析到信息
                case 1: 
                    udp.send({
                        address:'255.255.255.255',
                        port:8081,
                        message:'I GOT YOU'
                    });
                    steps = this.data.steps;
                    steps[1].success = true;
                    this.setData({ steps });                    
                    udp.offListening();
                    udp.offMessage();
                    udp.offClose();
                    udp.close();
                    wx.connectWifi({
                      SSID: ssid,
                      password: password,
                      success:()=>{
                          wx.onWifiConnected((result) => {
                              let steps = this.data.steps;
                              steps[2].success = true;
                              this.setData({ steps });
                              wx.hideLoading()
                              const newUdp = wx.createUDPSocket();
                              const newPort = newUdp.bind(50314);
                              newUdp.onListening(res => {
                                  console.log('再次监听中。。。');
                              });
                              newUdp.onMessage(re => {
                                    let _unit8Arr = new Uint8Array(re.message);
                                    let _encodedString = String.fromCharCode.apply(null, _unit8Arr);
                                    let _dat = decodeURIComponent(escape((_encodedString)));
                                    console.log("data:", _dat);
                                    newUdp.send({
                                        address:'255.255.255.255',
                                        port:8081,
                                        message:'BIND SUCCESS !'
                                    });
                                    newUdp.offListening();
                                    newUdp.offMessage();
                                    newUdp.offClose();
                                    newUdp.close();
                              })
                          });
                          wx.showToast({
                            title: '准备连接路由器',
                          })
                      }
                    });
                    break;
               //成功连接到路由器
            //     case 2:
            //         wx.showToast({
            //             title: '成功连接',
            //         })
            //         break;
            //     //连接失败路由器
            //     case 3:
            //         wx.showToast({
            //             title: '连接失败',
            //         })
            //         break;
            }
        })
    },

    lookPwd(){
      let pwdHide = !this.data.pwdHide;
      this.setData({ pwdHide });
    },
    inputPwd(e){
      this.setData({ password:e.detail.value })
    },
    inputDevicePWD(e){
        this.setData({ devicePWD:e.detail.value })
    },
    inputAcc(e){
      this.setData({ ssid:e.detail.value })
    },
    inputDeviceSSID(e){
        this.setData({ deviceSSID:e.detail.value })
    },

    onConnect(){
        const that = this;
        wx.showLoading({
          title: '连接中',
          mask:true
        })
        console.log("ssid:", this.data.deviceSSID, ",password:", this.data.devicePWD);
        wx.connectWifi({
          SSID: this.data.deviceSSID,
          password: this.data.devicePWD,
        }).then((res)=>{
            console.log(res);
            // if (res.wifiMsg===alreadyConnected) {
            //     wx.hideLoading();
            //     that.udpConnect();
            // }else{
            //     wx.onWifiConnected((result) => {
            //         wx.hideLoading();
            //         // that.setData({ active:++that.data.active });
            //         that.udpConnect();
            //     })  
            // }
        }).catch((err)=>{
            wx.hideLoading();
            wx.showToast({
              title: '连接失败',
              icon:'error'
            })
            console.error(err);
        });
        wx.onWifiConnected((result) => {
            wx.hideLoading();
            that.setData({ activeTop:++that.data.activeTop });
            that.udpConnect();
        })    
    },

    closeUDP(){
        this.data.udp.close();
    },

    onUnload(){
        try {
            let udp = this.data.udp;
            udp.offListening();
            udp.offMessage();
            udp.offClose();
            udp.close(); 
        } catch (error) {
            // console.error(error);
        }  
    },
    onShow(){
        this.getWifiInfo();
    }
});