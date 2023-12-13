<template>
    <div class="text-overline mb-1 forum-title">
        {{ getForumTitle(comment.forumID) }}
    </div>
    <v-img :width="280" :height="120" cover v-bind:src="post.imagePath"></v-img>
    <div class="text-h6 my-1 post-title">
        {{ getPostTitle(comment.postID) }}
    </div>
    <p class="text-subtitle-2 username"><span class="font-weight-bold">Posted by: </span>{{ getUserName(comment.userID) }}</p>
    <p class="text-subtitle-2 date-created"><span class="font-weight-bold">Date posted: </span>{{ timePassed }}</p>
    
</template>

<script>
import CommentService from '../services/CommentService'

export default {
    props: ['comment'],
    date() {
        return {
            comments: [],
        };
    },
    methods: {
        deleteComment() {
            CommentService.deleteComment(this.comment.commentID).then(() => {
                this.$emit('comment-deleted');
            });
        }
    },
    computed: {
        timePassed() {
            const postedTime = new Date(this.comment.dateCreated);
            let currentTime = new Date();
            let differenceInTime = (currentTime - postedTime) / 1000;
            if (Math.round(differenceInTime) === 1) { return "1 second ago"; }
            else if (Math.round(differenceInTime / 60) < 1) { return `${differenceInTime} seconds ago`; }
            else if (Math.round(differenceInTime / 60) == 1) { return "1 minute ago"; }
            else if (Math.round(differenceInTime / (60 * 60)) == 1) { return "1 hour ago"; }
            else if (Math.round(differenceInTime / (60 * 60 * 24)) == 1) { return "1 day ago"; }
            else if (Math.round(differenceInTime / (60 * 60 * 24 * 30)) == 1) { return "1 month ago"; }
            else if (Math.round(differenceInTime / (60 * 60 * 24 * 365)) == 1) { return "1 year ago"; }
            else { return `${Math.round(differenceInTime / (60 * 60 * 24 * 365))} years ago`; }
        },
        getForumTitle() {
            const forumId = this.post.forumId;
            const forum = this.$store.state.forums.find((forum) => forum.forumId === forumId);
            return forum ? forum.forumTitle : 'Forum Not Found';
        },
        getPostTitle() {
            const postId = this.post.postID;
            const post = this.$store.state.posts.find((post) => post.postID === postId);
            return post ? post.postTitle : 'Post Not Found';
        },
        getUserName() {
            const userId = this.post.userID;
            const user = this.$store.state.postedUsers.find((user) => user.userId === userId);
            return user ? user.userName : 'User Name Not Found';
        },
    },
}
</script>

<style>

.forum-title {
  height: 30px;
}
.post-title {
  height: 20px;
}
.username {
  height: 20px;
}
.date-created {
  height: 20px;
}

</style>