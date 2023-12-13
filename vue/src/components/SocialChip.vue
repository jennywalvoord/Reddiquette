<template>
<v-chip-group class="ma-2">
    <v-chip class="green" label size="small" @click="upVote" onclick="">
      <i class="fa-solid fa-up-long pr-2"></i>Upvote
      <div id="snackBar">You Must be Logged In to UpVote!</div>
    </v-chip>

    <v-chip class="red" label size="small" @click="downVote">
      <i class="fa-solid fa-down-long pr-2"></i>Downvote
    </v-chip>

    <v-chip class="grey" label size="small" @click=null>
      <i class="fa-regular fa-comment pr-2"></i>Comment
    </v-chip>

    <!-- <v-chip class="text-subtitle-2">Clout: {{ post.clout }}</v-chip> -->
    <i class="fa-solid fa-arrow-down-up-across-line"></i>
  </v-chip-group>
</template>

<script>

import { storeKey } from 'vuex';

export default {
  props: ['post', 'forum'], 
  data() {
    return {
      isUpvoted: false,
      isDownvoted: false,
    };
  },
  methods: {
  //   upVote() {
  //   if (!this.isUpvoted) {
  //     this.$store.dispatch('upVotePost', this.post.postID);
  //     this.isUpvoted = true;
  //     this.updateClout();
  //     this.updateLocalStorage();
  //   }
  // },
  // downVote() {
  //   if (!this.isDownvoted) {
  //     this.$store.dispatch('downVotePost', this.post.ID);
  //     this.isDownvoted = true;
  //     this.updateClout();
  //     this.updateLocalStorage();
  //   }
  // },
  // updateLocalStorage() {
  //   const posts = JSON.parse(localStorage.getItem('posts')) || [];
  //   const updatedPosts = posts.map(post => (post.id === this.post.id ? { ...post, upVote: this.post.upVote, downVote: this.post.downVote, clout: this.post.clout } : post));
  //   localStorage.setItem('posts', JSON.stringify(updatedPosts));
  // },
    updateClout() {
      const upVoteCount = this.$store.getters.getUpVoteCount; 
      const downVoteCount = this.$store.getters.getDownVoteCount; 
      this.$store.commit('updateClout', upVoteCount - downVoteCount);
    },
    getForumTitle(forumId) {
      const forum = this.$store.state.forums.find((forum) => forum.forumId === forumId);
      return forum ? forum.title : 'Forum Not Found';
    },
    loginPromt(){
      var x = document.getElementById("snackbar");
      x.className = "show";
      setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
    }
    
  },
  mounted() {
  // // Retrieve vote data from local storage when the component is mounted
  // const posts = JSON.parse(localStorage.getItem('posts')) || [];
  // const currentPost = posts.find(post => post.id === this.post.id);
  // if (currentPost) {
  //   this.isUpvoted = currentPost.upVote > 0;
  //   this.isDownvoted = currentPost.downVote > 0;
  // }
  
}
};
</script>