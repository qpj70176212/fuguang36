import http from "../utils/http";
import {reactive, ref} from "vue";

const user = reactive({
    login_type: 0,  // 登录类型
    account: "",  // 用户名
    password: "",  // 密码
    re_password: "",  // 确认密码
    mobile: "",  // 手机号
    code: "",  // 验证码
    remember: false,  // 是否记住登录
    // user_login(data) {
    login(data) {
        return http.post("/users/login/", data)
    },
    check_mobile(mobile) {
        // 验证手机号
        return http.get(`/users/mobile/${mobile}/`)
    }
})

export default user;