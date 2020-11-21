import {
  AUTH_REQUEST,
  AUTH_ERROR,
  AUTH_SUCCESS,
  AUTH_LOGOUT,
  AUTH_FAIL
} from "../actions/auth";
import { ADMIN_REQUEST, ADMIN_LOGOUT } from "../actions/admin";

const state = {
  status: "",
  hasLoadedOnce: false,
  authenticationStatus: false
};

const getters = {
  isAuthenticated: state => state.authenticationStatus,
  authStatus: state => state.status
};

const actions = {
  [AUTH_REQUEST]: ({ commit, dispatch }, user) => {
    return new Promise((resolve) => {
      commit(AUTH_REQUEST);
      
      // Check username and password credential
      if(user.admin.username !== user.username || user.admin.password !== user.password) {
        console.log("Invalid credential");
        commit(AUTH_FAIL);
        return;
      }
      
      commit(AUTH_SUCCESS);
      
      //log in user
      dispatch(ADMIN_REQUEST);
      resolve();
    });
  },
  [AUTH_LOGOUT]: ({ commit, dispatch }) => {
    return new Promise(resolve => {
      dispatch(ADMIN_LOGOUT);
      commit(AUTH_LOGOUT);
      resolve();
    });
  }
};

const mutations = {
  [AUTH_REQUEST]: state => {
    state.status = "loading";
  },
  [AUTH_SUCCESS]: (state) => {
    state.status = "success";
    state.authenticationStatus = true;
    state.hasLoadedOnce = true;
  },
  [AUTH_ERROR]: state => {
    state.status = "error";
    state.hasLoadedOnce = true;
  },
  [AUTH_LOGOUT]: (state) => {
    state.status = "logged out";
    state.authenticationStatus = false;
  },
  [AUTH_FAIL]: state => {
    state.status = "fail";
    state.hasLoadedOnce = true;
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
