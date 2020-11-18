import http from "../http/common/http-common";

class UserDataService {
    getAllUsersOfSameType(type, id) {
        return http.get(`/users?id=${id}&type=${type}`);
    }
}

export default new UserDataService();