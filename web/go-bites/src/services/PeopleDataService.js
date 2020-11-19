import http from '../http/common/http-common';

const url = '/people';

class PeopleDataService {
    getPeopleInformation() {
        return http.get(`${url}`);
    }

    getAPersonInformation(id) {
        return http.get(`${url}/person?id=${id}`);
    }

    updateAPersonInformation(id) {
        return http.put(`${url}?id=${id}`);
    }

    deleteAPersonInformation(id) {
        return http.delete(`${url}?id=${id}`);
    }
}

export default new PeopleDataService();