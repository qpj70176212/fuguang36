import http from "../utils/http";
import {reactive} from "vue";

const order = reactive({
    // course_list: [],     // 购物车中的商品课程列表
    total_price: 0,      // 勾选商品的总价格
    use_coupon: false,   // 用户是否使用优惠
    discount_type: 0,    // 0表示优惠券，1表示积分
    coupon_list: [], // 用户拥有的可用优惠券列表
    select: -1,          // 当前用户选中的优惠券
    credit: 0,           // 当前用户选择抵扣的积分
    fixed: true,         // 底部订单总价是否固定浮动
    pay_type: 0,         // 支付方式
    discount_price: 0,   // 本次下单的优惠抵扣价格
    credit_to_money: 0,  // 积分兑换现金的比例
    has_credit: 0,  // 用户拥有的积分
    max_use_credit: 0,  // 本次下单可用最大积分抵扣数量
    create_order(user_coupon_id, token) {
        // 生成订单
        return http.post("/orders/", {
            pay_type: this.pay_type,
            user_coupon_id: user_coupon_id,
            credit: this.credit,
        }, {
            headers: {
                Authorization: "jwt " + token,
            }
        })
    },
    get_enable_coupon_list(token){
        // 获取本次下单的可用优惠券列表
        return http.get("/coupon/user/",{
            headers:{
                Authorization: "jwt " + token,
            }
        })
    },
    alipay_page_pay(order_number) {
        // 获取订单的支付宝支付链接信息
        return http.get(`/payments/alipay/${order_number}`)
    }
})

export default order;