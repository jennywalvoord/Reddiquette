import axios from 'axios';

export default {
    createPost(post){
        return axios.post('/posts', post);
    },
    editPost(post){
        return axios.put('/posts:${id}', post);
    },
    deletePost(post){
        return axios.delete('/posts:${id}',post);
    }
}