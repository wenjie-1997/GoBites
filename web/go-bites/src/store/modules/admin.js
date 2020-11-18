import { ADMIN_REQUEST, ADMIN_ERROR, ADMIN_SUCCESS, ADMIN_LOGOUT } from "../actions/admin";

const state = { status: "", profileName: ""};

const getters = {
  getProfile: state => state.profileName,
  isProfileLoaded: state => !!state.profileName
};

const actions = {
  [ADMIN_REQUEST]: ({ commit }, admin) => {
    commit(ADMIN_REQUEST);
    commit(ADMIN_SUCCESS, admin);
  },
  [ADMIN_LOGOUT]: ({ commit }) => {
    commit(ADMIN_LOGOUT);
  }
};

const mutations = {
  [ADMIN_REQUEST]: state => {
    state.status = "loading";
  },
  [ADMIN_SUCCESS]: (state, admin) => {
    state.status = "success";
    state.profileName = `${admin.adminTitle} ${admin.adminName}`;
  },
  [ADMIN_ERROR]: state => {
    state.status = "error";
  },
  [ADMIN_LOGOUT]: state => {
    state.status = "log out";
    state.profileName = "";
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
