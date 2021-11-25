import http from "../utils/http";
import {reactive} from "vue";

const cart = reactive({
    course_list: [],  // 购物车中的商品列表
    total_price: 0,  // 购物车中的商品总价格
    selected_course_total: 0,  // 购物车中被勾选商品的数量
    checked: false,  // 购物车中是否全选商品了
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
    },
    get_course_from_cart(token) {
        return http.get("/cart/", {
            headers: {
                Authorization: "jwt " + token,
            }
        })
    },
    select_course(course_id, selected, token) {
        // 切换指定商品课程的勾选状态
        return http.patch("/cart/", {
            course_id,
            selected,
        }, {
            headers: {
                Authorization: "jwt " + token,
            }
        })
    },
    select_all_course(selected, token) {
        // 切换购物车对应商品课程的全选状态
        return http.put("/cart/", {
            selected,
        }, {
            headers: {
                Authorization: "jwt " + token,
            }
        })
    }
})

export default cart