import axios from 'axios';

export default {
    createPost(post){
        return axios.post('/createpost', post)
    },
    editPost(post){
        return axios.put('/createpost: id', post)
    },
    deletePost(post){
        return axios.delete('/createpost: id',post)
    }
}