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

    deleteARestaurantInformation(id) {
        return http.delete(`${url}?rid=${id}`, );
    }
}

export default new RestaurantDataService();