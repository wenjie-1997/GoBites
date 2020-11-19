import http from '../http/common/http-common';

const url = '/customers';

class CustomerDataService {
    getAllCustomersInformation() {
        return http.get(`${url}`);
    }

    getACustomerInformation(id) {
        return http.get(`${url}/customer?id=${id}`);
    }

    updateACustomerInformation(id) {
        return http.put(`${url}?id=${id}`);
    }

    deleteACustomerInformation(id) {
        return http.delete(`${url}?id=${id}`);
    }
}

export default new CustomerDataService();