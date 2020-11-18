import {
    SET_DELIVERY_DRIVER_USER_STATE
} from "../actions/deliveryDriverUser";

const state = {
    userId: "",
    userType: "",
    userName: "",
    userAge: "",
    userGender: "",
    userDeliveryMethod: "",
    userWorkArea: ""
};

const getters = {
    getDeliveryDriverId: state=> state.userId,
    getDeliveryDriverType: state=> state.userType,
    getDeliveryDriverName: state=> state.userName,
    getDeliveryDriverAge: state=> state.userAge,
    getDeliveryDriverGender: state=> state.userGender,
    getDeliveryDriverDeliveryMethod: state=> state.userDeliveryMethod,
    getDeliveryDriverWorkArea: state=> state.userWorkArea,
};

const actions = {
    [SET_DELIVERY_DRIVER_USER_STATE]: ({ commit }, deliveryDriverUser) => {
        commit(SET_DELIVERY_DRIVER_USER_STATE, deliveryDriverUser);
    }
};

const mutations = {
    [SET_DELIVERY_DRIVER_USER_STATE]: (state, deliveryDriverUser) => {
        state.userId = deliveryDriverUser.deliveryDriver.id;
        state.userType = deliveryDriverUser.deliveryDriver.type;
        state.userName = deliveryDriverUser.deliveryDriver.name;
        state.userAge = deliveryDriverUser.deliveryDriver.age;
        state.userGender = deliveryDriverUser.deliveryDriver.gender;
        state.userDeliveryMethod = deliveryDriverUser.deliveryDriver.deliveryMethod;
        state.userWorkArea = deliveryDriverUser.deliveryDriver.workArea;
    }
};

export default {
    state, 
    getters,
    actions, 
    mutations
};