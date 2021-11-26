import http from "../utils/http";
import {reactive} from "vue";

let order = reactive({
  // course_list: [],     // 购物车中的商品课程列表
  total_price: 0,      // 勾选商品的总价格
  use_coupon: false,   // 用户是否使用优惠
  discount_type: 0,    // 0表示优惠券，1表示积分
  coupon_list:[1,2,3], // 用户拥有的可用优惠券列表
  select: -1,          // 当前用户选中的优惠券
  credit: 0,           // 当前用户选择抵扣的积分
  fixed: true,         // 底部订单总价是否固定浮动
  pay_type: 0,         // 支付方式
})

export default order;