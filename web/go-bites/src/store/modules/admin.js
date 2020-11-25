import { ADMIN_REQUEST, ADMIN_ERROR, ADMIN_SUCCESS, ADMIN_LOGOUT } from "../actions/admin";

import AdminDataService from '../../services/AdminDataService';

const state = { status: "", profileName: "", profileIsLoaded: false};

const getters = {
  getProfile: state => state.profileName,
  isProfileLoaded: state => state.profileIsLoaded
};

const actions = {
  [ADMIN_REQUEST]: ({ commit }) => {
    AdminDataService.getAdminData()
      .then(resp => {
        commit(ADMIN_REQUEST)
        commit(ADMIN_SUCCESS, resp.data[0]);
      })
      .catch(err => {
        console.log(err);
      })
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
    state.profileIsLoaded = true;
  },
  [ADMIN_ERROR]: state => {
    state.status = "error";
  },
  [ADMIN_LOGOUT]: state => {
    state.status = "log out";
    state.profileIsLoaded = false;
    state.profileName = "";
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
