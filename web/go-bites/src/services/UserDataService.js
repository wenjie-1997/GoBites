import http from "../http/common/http-common";

class UserDataService {
    getAllUsersOfSameType(type, id) {
        return http.get(`/users?id=${id}&type=${type}`);
    }
    getAllCustomerUsernameWithTheSameType(type) {
        return http.get(`/users/type?type=${type}`);
    }
}

export default new UserDataService();