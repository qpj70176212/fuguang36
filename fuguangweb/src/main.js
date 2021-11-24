import { createApp } from 'vue'
import App from './App.vue'
import router from "./router";
import store from "./store"

import 'element-plus/dist/index.css'

import Vue3VideoPlayer from '@cloudgeek/vue3-video-player'
import '@cloudgeek/vue3-video-player/dist/vue3-video-player.css'

createApp(App).use(router).use(store).use(Vue3VideoPlayer, {
  lang: 'zh-CN'
}).mount('#app')
