import http from '../http/common/http-common';

const url = '/deliveryDrivers';

class DeliveryDriverDataService {
    getAllDeliveryDriversInformation() {
        return http.get(`${url}`);
    }

    getADeliveryDriverInformation(id) {
        return http.get(`${url}/deliveryDriver?id=${id}`);
    }

    updateADeliveryDriverInformation(id) {
        return http.put(`${url}?id=${id}`);
    }

    deleteADeliveryDriverInformation(id) {
        return http.delete(`${url}?id=${id}`);
    }
}

export default new DeliveryDriverDataService();