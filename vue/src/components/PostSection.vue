<template>
  <v-content class="post-section">
    <v-sheet class="citation">
      <h4>{{ getForumTitle(post.forumId) }}</h4>
      <v-row class="d-flex ">
        <v-col>
          <h6>Posted by: {{ getUserName(post.userId) }}</h6>
        </v-col>
        <v-col>
          <h6>Posted about  {{ post.dateCreated }}</h6>
        </v-col>
      </v-row>
    </v-sheet>
    <v-card class="postDetails">
      <v-container>
        <div class="d-flex flex-column w-66">
          <v-card-title class="d-flex justify-center">{{ post.title }}</v-card-title>
          <div class="d-flex">
            <v-img class="float-left" :width="300" :height="200" aspect-ratio="16/9" cover :src="post.image"></v-img>
            <v-card-text class="d-flex w-66 ">{{ post.body }} </v-card-text>
          </div>
        </div>
        <div>
          <v-chip-group class="ma-2">
            <v-chip class="green" label size="small" @click="upVote">
              <i class="fa-solid fa-up-long pr-2"></i>{{ post.upVote }} Upvotes
            </v-chip>

            <v-chip class="red" label size="small" @click="downVote">
              <i class="fa-solid fa-down-long pr-2"></i>{{ post.downVote }} Downvotes
            </v-chip>

            <v-chip class="grey" label size="small" @click=null>
              <i class="fa-regular fa-comment pr-2"></i>Comment
            </v-chip>

          </v-chip-group>
        </div>
      </v-container>
    </v-card>
    <v-divider :thickness="4" color="info"></v-divider>
    <div class="d-flex w-66 pa-5 ml-10 comment-button ">
      <v-btn block rounded="xl" size="x-large">Make a Comment</v-btn>
    </div>

</v-content></template>
    
<script>
import { storeKey } from 'vuex';

export default {
  props: ["post"],
  components: {
  },
  methods: {
    getForumTitle(forumId) {
      const forum = this.$store.state.forums.find((forum) => forum.id === forumId);
      return forum ? forum.title : 'Forum Not Found';
    },
    getUserName(userId) {
      const user = this.$store.state.postedUsers.find((user) => user.userId === userId);
      return user ? user.userName : 'User Name Not Found';
    },
    upVote() {
      if (!this.isUpvoted) {
        this.$store.dispatch('upVotePost', this.post.id);
        this.isUpvoted = true;
        this.updateClout();
        this.updateLocalStorage();
      }
    },
    downVote() {
      if (!this.isDownvoted) {
        this.$store.dispatch('downVotePost', this.post.id);
        this.isDownvoted = true;
        this.updateClout();
        this.updateLocalStorage();
      }
    },
  },
  computed: {
    timePassed(datePosted) {
      const postedTime = new Date(datePosted);
      let currentTime = new Date();
      let differenceInTime = (currentTime - postedTime)/1000;
      if (Math.round(differenceInTime) === 1) {return "1 second ago"}
      else if (Math.round(differenceInTime/60) < 1) {return `${differenceInTime} seconds ago`}
      else if (Math.round(differenceInTime/60) == 1) {return "1 minute ago"}
      else if (Math.round(differenceInTime/60) < 60) {return `${Math.round(differenceInTime/60)} minutes ago`}
      else if (Math.round(differenceInTime/(60*60)) == 1) {return "1 hour ago"}
      else if (Math.round(differenceInTime/(60*60)) < 24) {return `${Math.round(differenceInTime/(3600))} hours ago`}
      else if (Math.round(differenceInTime/(60*60*24)) == 1) {return "1 day ago"}
      else if (Math.round(differenceInTime/(60*60*24) < 30)) {return `${Math.round(differenceInTime/(60*60*24))} days ago`}
      else if (Math.round(differenceInTime/(60*60*24*30) == 1)) {return "1 month ago"}
      else if (Math.round(differenceInTime/(60*60*24*30) < 12)) {return `${Math.round(differenceInTime/(60*60*24*30))} months ago`}
      else if (Math.round(differenceInTime/(60*60*365) == 1)) {return "1 year ago"}
      else  return `${Math.round(differenceInTime/(60*60*365))} years ago`

    },
  }
}

</script>
    
<style>
.citation {
  margin: 7.5% auto auto auto;
}
.postDetails {
  margin-top: 100px;
}
#textArea {
  background-color: rgb(222, 222, 222);
}
</style>