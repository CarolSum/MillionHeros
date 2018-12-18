import Vue from 'vue'
import App from './App.vue'
import web3Plugin from './plugins/web3';

Vue.config.productionTip = false

// 使用插件引入全局web3和contracts对象
Vue.use(web3Plugin);

new Vue({
  render: h => h(App),
}).$mount('#app')
