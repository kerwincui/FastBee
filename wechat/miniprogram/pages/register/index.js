// miniprogram/pages/register/index.js
const registerOptions = {
  "admin": false,
  "avatar": "",
  "createBy": "",
  "createTime": "",
  "delFlag": "",
  "dept": {
    "ancestors": "",
    "children": [
      null
    ],
    "createBy": "",
    "createTime": "",
    "delFlag": "",
    "deptId": 0,
    "deptName": "",
    "email": "",
    "leader": "",
    "orderNum": "",
    "params": {},
    "parentId": 0,
    "parentName": "",
    "phone": "",
    "remark": "",
    "searchValue": "",
    "status": "",
    "updateBy": "",
    "updateTime": ""
  },
  "deptId": 0,
  "email": "",
  "loginDate": "",
  "loginIp": "",
  "nickName": "李四",
  "params": {},
  "password": "",
  "phonenumber": "",
  "postIds": [
    0
  ],
  "remark": "",
  "roleIds": [
    2
  ],
  "roles": [
    {
      "admin": false,
      "createBy": "",
      "createTime": "",
      "dataScope": "2",
      "delFlag": "",
      "deptCheckStrictly": true,
      "deptIds": [
        0
      ],
      "flag": true,
      "menuCheckStrictly": true,
      "menuIds": [
        0
      ],
      "params": {},
      "remark": "",
      "roleId": 2,
      "roleKey": "common",
      "roleName": "",
      "roleSort": "2",
      "searchValue": "",
      "status": "",
      "updateBy": "",
      "updateTime": ""
    }
  ],
  "salt": "",
  "searchValue": "",
  "sex": "",
  "status": "",
  "updateBy": "",
  "updateTime": "",
  "userId": 0,
  "userName": ""
}

const { loginApi } = require('../../API/request.js');


Page({

  /**
   * 页面的初始数据
   */
  data: {
    username:'',
    password:'',
    pwdAgain:'',
    phonenumber:'',
    email:'',
    emailError:'',
    radio:'0',
    phoneError:'',
    phoneValue:true,
    emailValue:true,
    nickName:'',
    nickError:'',
    nickValue:false,
    nameValue:false,
    nameError:'',
    pwdValue:false,
    pwdError:'',
    pwdAgainValue:false,
    pwdAgainError:''
  },
   
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    wx.setNavigationBarTitle({
      title: '用户注册',
    })
  },


  //测试接口，需修改
  async register(){
    if (!this.checkForm()) {
      return;
    }else{
      wx.showLoading({
        title: '正在注册',
      })
      let registerParams = registerOptions;
      registerParams.password = this.data.password;
      registerParams.userName = this.data.username;
      registerParams.nickName = this.data.nickName;
      registerParams.sex = this.data.radio;
      registerParams.phonenumber = this.data.phonenumber;
      registerParams.email = this.data.email;

      wx.request({
        url: 'http://localhost/dev-api/system/user/register',
        method:'POST',
        data:registerParams,
        timeout:10000,
        success(res){
          wx.hideLoading();
          if (res.data.code === 200) {
            wx.showToast({
              title: '注册成功',
              icon:'success'
            })
            setTimeout(() => {
              wx.redirectTo({
                url: '/pages/login/index',
              })
            }, 1000);  
          }else{
            wx.showToast({
              title: res.data.msg,
              icon:'error'
            })
          }
        }
      })
    }
    
    // const res = await loginApi('/system/user/register',{
    //   method:'POST',
    //   body:registerParams,
    //   json:true
    // });
    
    // console.log(formatDate());
  },

  //检查表单
  checkForm(){
    if (this.data.nickName === '') {
      this.setData({
        nickError:'昵称不能为空!'
      })
    }
    if (this.data.username === '') {
      this.setData({
        nameError:'账号不能为空!'
      })
    }
    if (this.data.password === '') {
      this.setData({
        pwdError:'密码不能为空!'
      })
    }
    return (this.data.nickValue && this.data.nameValue && this.data.pwdValue && this.data.pwdAgainValue && this.data.phoneValue && this.data.emailValue)
  },


  onChooseSex(e){
    this.setData({
      radio:e.detail
    })
  },

  // imputUsername(e){
  //   this.setData({
  //     username:e.detail
  //   })
  // },
  // imputPassword(e){
  //   this.setData({
  //     password:e.detail
  //   })
  // },
  endInputPwdAgain(e){
    if ((e.detail.value.trim()!=='') && (e.detail.value === this.data.password)) {
      this.setData({
        pwdAgainValue:true,
        pwdAgainError:''
      }) 
    }else{
      this.setData({
        pwdAgainValue:false,
        pwdAgainError:'密码输入不一致'
      })
    }
  },

  endInputNick(e){
    if (e.detail.value.trim() === '') {
      this.setData({ 
        nickValue:false,
        nickError:'昵称不能为空!'
      })
    }else{
      this.setData({
        nickName:e.detail.value,
        nickError:'',
        nickValue:true
      })
    }
  },

  endInputName(e){
    if (e.detail.value.trim() === '') {
      this.setData({ 
        nameValue:false,
        nameError:'账号不能为空!'
      })
    }else{
      this.setData({
        username:e.detail.value,
        nameError:'',
        nameValue:true
      })
    }
  },

  endInputPwd(e){
    if (e.detail.value.trim() === '') {
      this.setData({ 
        pwdValue:false,
        pwdError:'密码不能为空!'
      })
    }else{
      this.setData({
        password:e.detail.value,
        pwdError:'',
        pwdValue:true
      })
    }
  },

  endInputPhone(e){
    if (e.detail.value.trim() !== '') {
      const reg = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
      if(!reg.test(e.detail.value)){
        this.setData({ 
          phoneError:'请输入正确的手机号!',
          phoneValue:false 
        });
        return;
      }else{
        this.setData({ 
          phoneError:'',
          phoneValue:true,
          phonenumber:e.detail.value
         });
      };
    }else{
      this.setData({ 
        phoneError:'',
        phoneValue:true,
        phonenumber:''
       });
    }
  },

  endInputEmail(e){
    if (e.detail.value.trim() !== '') {
      const reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
      if(!reg.test(e.detail.value)){
        this.setData({ 
          emailError:'邮箱不合规范!',
          emailValue:false 
        });
        return;
      }else{
        this.setData({ 
          emailError:'',
          emailValue:true,
          email:e.detail.value
        });
      };
    }else{
      this.setData({ 
        emailError:'',
        emailValue:true,
        email:'' 
      });
    }
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})