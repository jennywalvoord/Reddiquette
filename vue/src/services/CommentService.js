import axios from 'axios';

export default {

    getComments() {
        const apiResponse = axios.get('https://localhost:44315/comment');
        console.log(apiResponse);
        return apiResponse;
    },
    getCommentsByPost(id) {
        return axios.get(`https://localhost:44315/comment/${id}`)
    },
    createComment(comment){
        return axios.post('https://localhost:44315/comment', comment);
    },
    editComment(comment){
        return axios.put('/comment:${id}', comment);
    },
    deletePost(comment){
        return axios.delete('/comment:${id}',comment);
    }
}