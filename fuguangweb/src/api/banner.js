import http from "../utils/http";

// 获取轮播广告信息
export function get_banner() {
    return http.get("/banner")
}