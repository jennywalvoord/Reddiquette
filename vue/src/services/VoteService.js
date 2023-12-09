import axios from 'axios';

// TODO: figure out what the path needs to be
export default {
    createPostVote(post){
        return axios.post('/createpost', post)
    },
    updatePostVote(post){
        return axios.put('/createpost: id', post)
    },
    removePostVote(post){
        return axios.delete('/createpost: id',post)
    },
    checkPostVote(post){
        return axios.get('/???: id', post)
    },
    upvoteComment(post){
        return axios.post('/createpost', post)
    },
    downvoteComment(post){
        return axios.put('/createpost: id', post)
    },
    removeCommentVote(post){
        return axios.delete('/createpost: id',post)
    }
}