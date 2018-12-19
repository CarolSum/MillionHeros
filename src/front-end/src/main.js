import Vue from 'vue'
import App from './App.vue'
import web3Plugin from './plugins/web3';
import router from './router.js'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
Vue.config.productionTip = false

// 使用插件引入全局web3和contracts对象
Vue.use(web3Plugin);
// 使用vue-router

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
