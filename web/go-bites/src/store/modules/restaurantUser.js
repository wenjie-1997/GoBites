import {
    SET_RESTAURANT_USER_STATE
} from "../actions/restaurantUser"

const state = {
    userId: "",
    userType: "",
    userName: "",
    userAddress: "",
    userCity: "",
    userState: "",
    userZipCode: "",
    userCountry: "",
    userRating: "",
    userTotalCustomer: ""
};

const getters = {
    getRestaurantId: state=> state.userId,
    getRestaurantType: state=> state.userType,
    getRestaurantName: state=> state.userName,
    getRestaurantAddress: state=> state.userAddress,
    getRestaurantCity: state=> state.userCity,
    getRestaurantState: state=> state.userState,
    getRestaurantZipCode: state=> state.userZipCode,
    getRestaurantCountry: state=> state.userCountry,
    getRestaurantRating: state=> state.userRating,
    getRestaurantTotalCustomer: state=> state.userTotalCustomer,
};

const actions = {
    [SET_RESTAURANT_USER_STATE]: ({ commit }, restaurantUser) => {
        commit(SET_RESTAURANT_USER_STATE, restaurantUser);
    }
};

const mutations = {
    [SET_RESTAURANT_USER_STATE]: (state, restaurantUser) => {
        state.userId = restaurantUser.restaurant.id;
        state.userType = restaurantUser.restaurant.type;
        state.userName = restaurantUser.restaurant.name;
        state.userAddress = restaurantUser.restaurant.address;
        state.userCity = restaurantUser.restaurant.city;
        state.userState = restaurantUser.restaurant.state;
        state.userZipCode = restaurantUser.restaurant.zipCode;
        state.userCountry = restaurantUser.restaurant.Country;
        state.userRating = restaurantUser.restaurant.rating;
        state.userTotalCustomer = restaurantUser.restaurant.totalCustomer;
    }
};

export default {
    state, 
    getters,
    actions,
    mutations
}