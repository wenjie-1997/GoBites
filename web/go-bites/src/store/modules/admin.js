import { ADMIN_REQUEST, ADMIN_ERROR, ADMIN_SUCCESS } from "../actions/admin";
import apiCall from "../../utils/api";
import Vue from "vue";
import { AUTH_LOGOUT } from "../actions/auth";

const state = { status: "", profile: {} };

const getters = {
  getProfile: state => state.profile,
  isProfileLoaded: state => !!state.profile.name
};

const actions = {
  [ADMIN_REQUEST]: ({ commit, dispatch }) => {
    commit(ADMIN_REQUEST);
    apiCall({ url: "admin/me" })
      .then(resp => {
        commit(ADMIN_SUCCESS, resp);
      })
      .catch(() => {
        commit(ADMIN_ERROR);
        // if resp is unauthorized, logout, to
        dispatch(AUTH_LOGOUT);
      });
  }
};

const mutations = {
  [ADMIN_REQUEST]: state => {
    state.status = "loading";
  },
  [ADMIN_SUCCESS]: (state, resp) => {
    state.status = "success";
    Vue.set(state, "profile", resp);
  },
  [ADMIN_ERROR]: state => {
    state.status = "error";
  },
  [AUTH_LOGOUT]: state => {
    state.profile = {};
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
