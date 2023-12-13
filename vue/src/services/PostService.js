import axios from 'axios';

export default {

    getPosts() {
        const apiResponse = axios.get('https://localhost:44315/posts');
        console.log("test");
        console.log(apiResponse);
        return apiResponse;
    },
    
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