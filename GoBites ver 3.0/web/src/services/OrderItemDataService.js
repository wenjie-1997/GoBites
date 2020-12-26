import http from "../http/common/http-common";

class OrderItemDataService {
    getAllOrderItems() {
        return http.get(`/orderItems`);
    }
}

export default new OrderItemDataService();