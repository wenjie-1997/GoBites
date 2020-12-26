import http from "../http/common/http-common";

class MenuItemDataService {
    getAllMenuItems() {
        return http.get(`/menuItems`);
    }
}

export default new MenuItemDataService();