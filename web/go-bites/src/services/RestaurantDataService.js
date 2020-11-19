import http from '../http/common/http-common';

const url = '/restaurants';

class RestaurantDataService {
    getAllRestaurantsInformation() {
        return http.get(`${url}`);
    }

    getARestaurantInformation(id) {
        return http.get(`${url}/restaurant?id=${id}`);
    }

    updateARestaurantInformation(id) {
        return http.put(`${url}?id=${id}`);
    }

    deleteARestaurantInformation(id) {
        return http.delete(`${url}?id=${id}`);
    }
}

export default new RestaurantDataService();