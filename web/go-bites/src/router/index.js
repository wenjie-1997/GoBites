import Vue from 'vue'
import Router from 'vue-router'
import store from "../store";
import Home from '../components/Home.vue'
import Login from '../components/Login.vue'
import Restaurant from '../components/Restaurant.vue';
import Customer from '../components/Customer.vue';
import Profile from '../components/Profile.vue';

Vue.use(Router)

const ifNotAuthenticated = (to, from, next) => {
    if (!store.getters.isAuthenticated) {
      next();
      return;
    }
    next("/");
  };
  
  const ifAuthenticated = (to, from, next) => {
    if (store.getters.isAuthenticated) {
      next();
      return;
    }
    next("/login");
  };

export default new Router({
    mode: 'history',
    routes: [
        {
          path: '/',
          component: Home,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/login',
          component: Login,
          beforeEnter: ifNotAuthenticated
        },
        {
          path: '/restaurant',
          component: Restaurant,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/customer',
          component: Customer,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/profile',
          component: Profile,
          beforeEnter: ifAuthenticated
        }
    ],
})