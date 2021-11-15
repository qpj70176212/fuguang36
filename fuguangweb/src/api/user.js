import http from "../utils/http";
import {reactive, ref} from "vue";

const user = reactive({
    login_type: 0,  // 登录类型
    account: "",  // 用户名
    password: "",  // 密码
    re_password: "",  // 确认密码
    mobile: "",  // 手机号
    sms_code: "",  // 验证码
    remember: false,  // 是否记住登录
    is_send: false,  // 是否处于短信发送冷却状态中
    sms_interval: 60,  // 短信发送的冷却时间
    interval: null,  // 短信倒计时的返回值标记符
    sms_btn_text: "点击获取验证码",  // 发送短信按钮的文本提示

    // user_login(data) {
    login(data) {
        // 用户登录请求
        return http.post("/users/login/", data)
    },
    check_mobile(mobile) {
        // 验证手机号
        return http.get(`/users/mobile/${mobile}/`)
    },
    register(data){
        // 用户注册请求
        return http.post("/users/register/", data)
    },
    get_sms_code() {
        // 发送短信
        return http.get(`/users/sms/${this.mobile}`)
    }
})

export default user;