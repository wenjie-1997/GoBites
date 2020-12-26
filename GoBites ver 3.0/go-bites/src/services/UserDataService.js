import http from "../http/common/http-common";

class UserDataService {
    getAllUsersOfSameType(type) {
        return http.get(`/users/type?type=${type}`);
    }
    getAUser(id) {
        return http.get(`/users/user?uid=${id}`);
    }
}

export default new UserDataService();