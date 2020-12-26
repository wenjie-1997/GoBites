import {
    SET_CUSTOMER_USER_STATE
} from "../actions/customerUser"

const state = {
    personId: 0,
    customerId: 0,
    userName: ""
};

const getters = {
    getCustomerId: state=> state.customerId,
    getCustomerPersonId: state=> state.personId,
    getCustomerUserName: state => state.userName,
};

const actions = {
    [SET_CUSTOMER_USER_STATE]: ({ commit }, customerUser) => {
        commit(SET_CUSTOMER_USER_STATE, customerUser);
    }
};

const mutations = {
    [SET_CUSTOMER_USER_STATE]: (state, customerUser) => {
        state.userId = customerUser.customer.id;
        state.userType = customerUser.personId;
        state.userName = customerUser.userName;
    }
};

export default {
    state,
    getters,
    actions, 
    mutations
};