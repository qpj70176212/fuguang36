import axios from "axios";
import settings from "../settings.js"

const http = axios.create({
    // timeout: 2500,
    // baseURL: "http://api.fuguang.cn:8000",
    baseURL: settings.host,
    withCredentials: false
})

// 请求拦截器
http.interceptors.request.use((config)=>{
    console.log("http请求之前")
    return config
}), (error)=>{
    console.log("http请求错误")
    return Promise.reject(error)
}

// 响应拦截器
http.interceptors.response.use((response)=>{
    console.log("服务端响应数据成功以后，返回结果给客户端的第一时间，执行then之前")
    return response;
}, (error)=>{
    console.log("服务端响应错误内容的时候...")
    return Promise.reject(error)
})

export default http;