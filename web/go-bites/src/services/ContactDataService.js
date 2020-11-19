import http from '../http/common/http-common';

const url = '/contacts';

class ContactDataService {
    getAContactPersonInformation(id) {
        return http.get(`${url}/contact/person?id=${id}`);
    }

    getAContactRestaurantInformation(id) {
        return http.get(`${url}/contact/restaurant?id=${id}`);
    }

    updateAContactInformation(id) {
        return http.put(`${url}?id=${id}`);
    }

    deleteAContactInformation(id) {
        return http.delete(`${url}?id=${id}`);
    }
}

export default new ContactDataService();