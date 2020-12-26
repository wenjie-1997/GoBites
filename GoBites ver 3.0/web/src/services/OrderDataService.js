import http from "../http/common/http-common";

class OrderDataService {
    getAllOrders() {
        return http.get(`/orders`);
    }
}

export default new OrderDataService();