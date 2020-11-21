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

    deleteACustomerInformation(customer) {
        return http.delete(`${url}`, customer);
    }
}

export default new CustomerDataService();