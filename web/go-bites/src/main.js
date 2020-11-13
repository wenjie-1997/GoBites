import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from "./store"
import Loading from "./mixins/loading.vue";

Vue.config.productionTip = false

Vue.component("loading", Loading);

new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')
