import http from '../http/common/http-common';

const url = '/customers';

class CustomerDataService {
    getAllCustomersInformation() {
        return http.get(`${url}`);
    }

    getACustomerInformation(id) {
        return http.get(`${url}/customer?cid=${id}`);
    }

    updateACustomerInformation(customer) {
        return http.put(`${url}`, customer);
    }

    deleteACustomerInformation(id) {
        return http.delete(`${url}?cid=${id}`);
    }
}

export default new CustomerDataService();