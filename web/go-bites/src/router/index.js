import Vue from 'vue'
import Router from 'vue-router'
import store from "../store";
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Restaurant from '../views/Restaurant.vue';
import OrderList from '../views/OrderList.vue';
import Customer from '../views/Customer.vue';
import Profile from '../views/Profile.vue';
import UserDetails from '../views/UserDetails.vue';
import ViewMenuList from '../views/ViewMenuList.vue';
import BreakfastMenu from '../views/BreakfastMenu.vue';
import DinnerMenu from '../views/DinnerMenu.vue';
import LunchMenu from '../views/LunchMenu.vue';
import TeatimeMenu from '../views/TeatimeMenu.vue';

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
          path: '/orderList',
          component: OrderList,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/profile',
          component: Profile,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/userDetails',
          component: UserDetails,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/viewMenuList',
          component: ViewMenuList,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/breakfastMenu',
          component: BreakfastMenu,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/dinnerMenu',
          component: DinnerMenu,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/lunchMenu',
          component: LunchMenu,
          beforeEnter: ifAuthenticated
        },
        {
          path: '/teatimeMenu',
          component: TeatimeMenu,
          beforeEnter: ifAuthenticated
        },
    ],
})