import axios from 'axios';

export default axios.create({
    baseURL: "https://go-bites-server.herokuapp.com/api",
    headers: {
        "Content-Type": "application/json"
    }
});