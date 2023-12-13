<template>
<v-container>
  <v-row align="center" justify="center">
    <v-col
      cols="auto">
      <v-card
          class="mx-auto"
          max-width="280"
        >
          <v-card-item>
            <div>
              <div class="text-overline mb-1">
                {{ getForumTitle(post.forumId) }}
              </div>
              <v-img :width="280" :height="120" cover v-bind:src="post.image"></v-img>
              
              <div class="text-h6 my-1">
                {{ post.title }}
              </div>
              <p class="text-subtitle-2"><span class="font-weight-bold">Date posted: </span>{{ post.dateCreated }}</p>
                <p class="text-subtitle-2">
                  <span class="font-weight-bold" :class="{ 'text-positive': post.clout > 0, 'text-negative': post.clout < 0 }">
                    Clout:
                  </span>
                  {{ post.clout }}
                </p>
              <v-card value="rounded" color="grey-lighten-3" flat height="150" class="overflow-hidden">
                <v-card-text>
                  {{ truncateText(post.body, 150) }}
                </v-card-text>
              </v-card>
              <v-divider class="ma-4"></v-divider>
                <v-chip-group 
                  v-model="selection"
                  selected-class="text-deep-orange-accent-4">
                  <v-chip class="green" label size="x-small" @click="upVote">
                    <i class="fa-solid fa-up-long pr-2"></i>Upvote
                  </v-chip>

                  <v-chip class="red" label size="x-small" @click="downVote">
                    <i class="fa-solid fa-down-long pr-2"></i>Downvote
                  </v-chip>

                  <v-chip class="grey" label size="x-small" @click=null>
                    <i class="fa-regular fa-comment pr-2"></i>Comment
                  </v-chip>
                </v-chip-group>
            </div>
          </v-card-item>

          <v-card-actions>
            <v-btn  block>
            <router-link v-bind:to="{ name: 'post-view', params: { id: post.id } }">
              
              View Post Details
            </router-link>
          </v-btn>
            
          </v-card-actions>
        </v-card>
    </v-col>
  </v-row>
</v-container>


</template>

<script>
import { storeKey } from 'vuex';
import PostService from '../services/PostService';
export default {
  props: ['post', 'forum'], 
  data() {
    return {
      isUpvoted: false,
      isDownvoted: false,
    };
  },
  methods: {
    truncateText(text, limit) {
      if (text.length > limit) {
        return text.substring(0, limit) + "...";
      } else {
        return text;
      }
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
  updateLocalStorage() {
    const posts = JSON.parse(localStorage.getItem('posts')) || [];
    const updatedPosts = posts.map(post => (post.id === this.post.id ? { ...post, upVote: this.post.upVote, downVote: this.post.downVote, clout: this.post.clout } : post));
    localStorage.setItem('posts', JSON.stringify(updatedPosts));
  },
    updateClout() {
      const upVoteCount = this.$store.getters.getUpVoteCount; 
      const downVoteCount = this.$store.getters.getDownVoteCount; 
      this.$store.commit('updateClout', upVoteCount - downVoteCount);
    },
    getForumTitle(forumId) {
      const forum = this.$store.state.forums.find((forum) => forum.forumId === forumId);
      return forum ? forum.forumTitle : 'Forum Not Found';
    },
    
  },
  mounted() {
  // Retrieve vote data from local storage when the component is mounted
  const posts = JSON.parse(localStorage.getItem('posts')) || [];
  const currentPost = posts.find(post => post.id === this.post.id);
  if (currentPost) {
    this.isUpvoted = currentPost.upVote > 0;
    this.isDownvoted = currentPost.downVote > 0;
  }
  
},
// created() {
//     PostService.getForums().then(response => {
//     this.$store.commit("SET_POSTS", response.data); 
//     }) 
//   },
};
</script>

<style>
.text-positive {
  color: green;
}
.text-negative {
  color: red;
}
.small-post a {
  text-decoration: none;
}
</style>

<!-- <style>
.card {
  max-width: 600px;
 

}
img {
  border-radius: 8px;
  height: 200px;
}
.well {
    display: flex;
    gap: 24px;
}
.social {
    display: flex;
    align-items: center;
}
.vote,
.comment,
.reply {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 10px 20px;
}
.arrow {
    font-size: 20px;
    margin-right: 5px;
}
.comment-icon {
    font-size: 20px;
    margin-right: 5px;
}
.vote a,
.comment a,
.reply a {
    text-decoration: none;
    color: #333;
}
.vote p,
.comment p,
.reply p {
    margin: 0;
    padding: 0;
}
</style> -->