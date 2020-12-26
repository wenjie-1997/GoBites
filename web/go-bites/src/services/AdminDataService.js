import http from "../http/common/http-common";

class AdminDataService {
    getAdminData() {
        return http.get(`/admin`);
    }
}

export default new AdminDataService();