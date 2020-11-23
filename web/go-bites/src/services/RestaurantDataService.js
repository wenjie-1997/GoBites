import http from '../http/common/http-common';

const url = '/restaurants';

class RestaurantDataService {
    getAllRestaurantsInformation() {
        return http.get(`${url}`);
    }

    getARestaurantInformation(id) {
        return http.get(`${url}/restaurant?rid=${id}`);
    }

    updateARestaurantInformation(restaurant) {
        return http.put(`${url}`, restaurant);
    }

    deleteARestaurantInformation(restaurant) {
        return http.delete(`${url}`, restaurant);
    }
}

export default new RestaurantDataService();