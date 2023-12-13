import axios from 'axios';

export default {

    list() {
        return axios.get('/comment');
    },
    createComment(comment){
        return axios.post('/comment', comment);
    },
    editComment(comment){
        return axios.put('/comment:${id}', comment);
    },
    deletePost(comment){
        return axios.delete('/comment:${id}',comment);
    }
}