import http from '../http/common/http-common';

const url = '/addresses';

class AddressDataService {
    getAAddressPersonInformation(id) {
        return http.get(`${url}/address/person?id=${id}`);
    }

    getAAddressRestaurantInformation(id) {
        return http.get(`${url}/address/restaurant?id=${id}`);
    }

    updateAAddressInformation(id) {
        return http.put(`${url}?id=${id}`);
    }

    deleteAAddressInformation(id) {
        return http.delete(`${url}?id=${id}`);
    }
}

export default new AddressDataService();