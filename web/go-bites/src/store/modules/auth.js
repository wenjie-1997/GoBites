import {
  AUTH_REQUEST,
  AUTH_ERROR,
  AUTH_SUCCESS,
  AUTH_LOGOUT,
  AUTH_FAIL
} from "../actions/auth";
import { USER_REQUEST } from "../actions/user";
import apiCall from "../../utils/api";
// import axios from 'axios';

// import admin.js for getting admin username and password
import {
  admin
} from "../../assets/admin";

const state = {
  token: localStorage.getItem("user-token") || "",
  status: "",
  hasLoadedOnce: false
};

const getters = {
  isAuthenticated: state => !!state.token,
  authStatus: state => state.status
};

const actions = {
  [AUTH_REQUEST]: ({ commit, dispatch }, user) => {
    return new Promise((resolve, reject) => {
      commit(AUTH_REQUEST);
      
      // Check username and password credential
      if(admin.username !== user.username || admin.password !== user.password) {
        console.log("Invalid credential");
        commit(AUTH_FAIL);
        return;
      }

      /* This method is used to replace axios
       * Please do not delete this function
       * Let it become comments instead
      */
      apiCall({ url: "auth", data: user, method: "POST" })
        .then(resp => {
          const token = resp.token;
          localStorage.setItem("user-token", resp.token); // store token into localStorage

          commit(AUTH_SUCCESS, token);

          // You have your token, now log in user
          dispatch(USER_REQUEST);
          resolve(resp);

          console.log("Login Success");
        })
        .catch(err => {
          commit(AUTH_ERROR, err);
          localStorage.removeItem("user-token"); // If the request fails, remove any possible user
          reject(err);
        });
      
      /* Runtime Error! Failed to resolve by Ainal */
      // axios({ url: "auth", data: user, method: "POST" })
      //   .then(resp => {
      //     const token = resp.data.token
      //     localStorage.setItem("user-token", token); // store token into localStorage

      //     commit(AUTH_SUCCESS, token);

      //     console.log(`Token ${ state.token }`);
      //     // You have your token, now log in user
      //     dispatch(USER_REQUEST);
      //     resolve(resp);
      //   })
      //   .catch(err => {
      //     commit(AUTH_ERROR, err);
      //     localStorage.removeItem("user-token"); // If the request fails, remove any possible user
      //     reject(err);
      //   });
    });
  },
  [AUTH_LOGOUT]: ({ commit }) => {
    return new Promise(resolve => {
      commit(AUTH_LOGOUT);
      localStorage.removeItem("user-token"); // clear user's token from localstorage
      resolve();
    });
  }
};

const mutations = {
  [AUTH_REQUEST]: state => {
    state.status = "loading";
  },
  [AUTH_SUCCESS]: (state, token) => {
    state.status = "success";
    state.token = token;
    state.hasLoadedOnce = true;
  },
  [AUTH_ERROR]: state => {
    state.status = "error";
    state.hasLoadedOnce = true;
  },
  [AUTH_LOGOUT]: state => {
    state.token = "";
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
