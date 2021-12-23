import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
      vue(),
      Components({
      resolvers: [ElementPlusResolver() ],
    }),
       AutoImport({
      resolvers: [ElementPlusResolver()],
    }),
  ],
    server: {
      port: '3000',
        host: 'www.fuguang.cn',
        proxy: {
          '/api': {
              target: 'http://api.fuguang.cn:8000/',
              // target: "47.94.193.33",
              changeOrigin: true,
              ws: true,
              rewrite: path => path.replace(/^\/api/, '')
          }
        }

    }
})