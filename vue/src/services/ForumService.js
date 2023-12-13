import axios from 'axios';

export default {
    getForums() {
        const apiResponse = axios.get('https://localhost:44315/forum');
        console.log("test");
        console.log(apiResponse);
        return apiResponse;
    }, 

    getForum(id) {
        return axios.get(`https://localhost:44315/forum/${id}`)
    }

}