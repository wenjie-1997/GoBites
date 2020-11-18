import http from "../http/common/http-common";

class AdminDataService {
    getAdminData(id) {
        return http.get(`/admins?id=${id}`);
    }
}

export default new AdminDataService();