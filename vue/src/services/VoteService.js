import axios from 'axios';

// TODO: figure out what the path needs to be
export default {
    GetAllPostVotesbyId(id){
        return axios.get(`/vote/post/${id}`)
    },
    GetPostVoteByID(postId, userId) {
        return axios.get(`/vote/post/${postId}/user/${userId}`)
    },
    GetAllCommentVotesById(id){
        return axios.get(`/vote/comment/${id}`)
    },
    CreatePostVote(vote){
        return axios.post('/vote/post',vote)
    },
    CreateCommentVote(vote){
        return axios.post('/vote/comment', vote)
    },
    UpdateCommentVote(userId, targetID, increment){
        return axios.put(`/vote/comment/${targetID}`, userId, targetID, increment)
    },
    UpdatePostVote(userId, targetID, increment){
        return axios.put(`/vote/comment/${targetID}`, userId, targetID, increment)
    },
    DeletePostVote(targetID, UserID){
        return axios.delete(`/vote/post/${targetID}/user/${UserID}`)
    },
    DeleteCommentVote(targetID, userID){
        return axios.delete(`/vote/comment/${targetID}/user/${userID}`)
    }
}