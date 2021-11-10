import http from "../utils/http";
import {ref, reactive} from "vue";

// 获取轮播广告信息
// export function get_banner() {
//     return http.get("/banner")
// }

const banner = reactive({
    banner_list: [],
    get_banner() {
        return http.get("/banner/")
    }
})

export default banner;