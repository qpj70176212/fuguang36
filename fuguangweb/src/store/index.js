import { createStore } from 'vuex'
import createPersistedState from "vuex-persistedstate"

// 实例化一个vuex存储库
export default createStore({
  // 调用永久存储vuex数据的插件，localstorage里会多一个名叫vuex的key，里面就是vuex的数据
  plugins: [createPersistedState()],
  state () { // 数据存储位置，相当于组件中的data
    return {
      user: {},  // 登录用户信息
      cart_total: 0, // 购物车中的商品数量
    }
  },
  getters: {
    getUserInfo(state) {
      let now = parseInt((new Date() - 0) / 1000)
      if (state.user.exp === undefined) {
        // 没登录
        state.user = {}
        localStorage.token = null
        sessionStorage.token = null
        return null
      }

      if (parseInt(state.user.exp) < now) {
        // 过期处理
        console.log("过期处理")
        state.user = {}
        localStorage.token = null
        sessionStorage.token = null
        return null
      }
      return state.user
    }
  },
  mutations: { // 操作数据的方法，相当于methods
    login (state, user) { // state 就是上面的state  state.user就是上面的数据
      state.user = user
    },
    logout(state) {  // 退出登录
      localStorage.removeItem("token")
      sessionStorage.removeItem("token")
      // localStorage.token = null;
      // sessionStorage.token = null;
      state.user = {}
    },
    set_cart_total(state, total) {
      // 设置商品数量的总数
      state.cart_total = total
    },
  }
})

