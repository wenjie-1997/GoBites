import Vue from 'vue'
import Router from 'vue-router'
import store from "../store";
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Restaurant from '../views/Restaurant.vue';
import Customer from '../views/Customer.vue';
import Profile from '../views/Profile.vue';
import DeliveryDriver from '../views/DeliveryDriver.vue';
import UserDetails from '../views/UserDetails.vue';

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
        }, 
        {
          path: '/deliveryDriver',
          component: DeliveryDriver,
          beforeEnter: ifAuthenticated
        }, 
        {
          path: '/userDetails',
          component: UserDetails,
          beforeEnter: ifAuthenticated
        }
    ],
})