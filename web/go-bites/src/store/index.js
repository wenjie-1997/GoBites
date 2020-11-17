import Vue from "vue";
import Vuex from "vuex";
import admin from "./modules/admin";
import auth from "./modules/auth";
import customerUser from "./modules/customerUser";
import restaurantUser from "./modules/restaurantUser";
import deliveryDriverUser from "./modules/deliveryDriverUser";

Vue.use(Vuex);

const debug = process.env.NODE_ENV !== "production";

export default new Vuex.Store({
  modules: {
    admin,
    auth,
    customerUser,
    restaurantUser,
    deliveryDriverUser
  },
  strict: debug
});
