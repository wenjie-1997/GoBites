import {
    SET_CUSTOMER_USER_STATE
} from "../actions/customerUser"

const state = {
    userId: "",
    userType: "",
    userName: "",
    userAddress: "",
    userCity: "",
    userState: "",
    userZipCode: "",
    userCountry: "",
    userTotalOrderMade: "",
};

const getters = {
    getCustomerId: state=> state.userId,
    getCustomerType: state=> state.userType,
    getCustomerName: state=> state.userName,
    getCustomerAddress: state=> state.userAddress,
    getCustomerCity: state=> state.userCity,
    getCustomerState: state=> state.userState,
    getCustomerZipCode: state=> state.userZipCode,
    getCustomerCountry: state=> state.userCountry,
    getCustomerTotalOrderMade: state=> state.userTotalOrderMade,
};

const actions = {
    [SET_CUSTOMER_USER_STATE]: ({ commit }, customerUser) => {
        commit(SET_CUSTOMER_USER_STATE, customerUser);
    }
};

const mutations = {
    [SET_CUSTOMER_USER_STATE]: (state, customerUser) => {
        state.userId = customerUser.customer.id;
        state.userType = customerUser.customer.type;
        state.userName = customerUser.customer.name;
        state.userAddress = customerUser.customer.address;
        state.userCity = customerUser.customer.city;
        state.userState = customerUser.customer.state;
        state.userZipCode = customerUser.customer.zipCode;
        state.userCountry = customerUser.customer.Country;
        state.userTotalOrderMade = customerUser.customer.totalOrderMade;
    }
};

export default {
    state,
    getters,
    actions, 
    mutations
};