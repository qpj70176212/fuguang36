import http from "../utils/http";
import {reactive} from "vue";

const cart = reactive({
    add_course_to_cart(course_id, token) {
        // 添加课程到购物车
        return http.post("/cart/", {
            course_id,  // course_id: course_id,
        }, {
            headers: {
                // 因为当前课程端添加课程商品到购物车必须登录，所以接口操作时必须发送jwt
                Authorization: "jwt " + token, // 注意：jwt字符串与token之间务必有空格！否则无法认证
            }
        })
    }
})

export default cart