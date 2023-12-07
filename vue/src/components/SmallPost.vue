<template>
  <v-content>
        <router-link  v-bind:to="{ name: 'post-view', params: { id: post.id } }">
    <v-card width="300" class="overflow-hidden">
    
      <v-img :width="300" :height="200" aspect-ratio="16/9" cover v-bind:src="post.image"></v-img>

      <v-card-title primary-title>
        <div>
          <div class="headline text-center">{{ post.title }}</div>
          <p class="text-subtitle-2">Date posted: {{ post.dateCreated }}</p>
          <p class="text-subtitle-2">Clout: {{ post.clout }}</p>
          
          <v-flex xs6 sm4 md2>
            <div>
              <v-chip small class="ma-2" color="orange" label size="small">
                {{ getForumTitle(post.forumId) }}
              </v-chip>
            </div>
          </v-flex>
          
        
        </div>
      </v-card-title>
      <v-card flat height="150" class="overflow-hidden">
        <v-card-text>
          <span style="text-wrap: wrap">{{ post.body.substring(0, 250) }}...</span>

        </v-card-text>
      </v-card>
      </v-card>
    </router-link>
      

      <v-chip-group class="ma-2">
        <v-chip class="green" label size="small" @click="upVote">
          <i class="fa-solid fa-up-long pr-2"></i>Upvote
        </v-chip>

        <v-chip class="red" label size="small" @click="downVote">
          <i class="fa-solid fa-down-long pr-2"></i>Downvote
        </v-chip>

        <v-chip class="grey" label size="small" @click=null>
          <i class="fa-regular fa-comment pr-2"></i>Comment
        </v-chip>
      </v-chip-group>
  </v-content>
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
    upVote() {
      if (!this.isUpvoted) {
        this.$store.dispatch('upVotePost', this.post.id);
        this.isUpvoted = true;
        this.updateClout(); 
      }
    },
    downVote() {
      if (!this.isDownvoted) {
        this.$store.dispatch('downVotePost', this.post.id);
       this.isDownvoted = true;
        this.updateClout(); 
      }
    },
    updateClout() {
      const upVoteCount = this.$store.getters.getUpVoteCount; 
      const downVoteCount = this.$store.getters.getDownVoteCount; 
      this.$store.commit('updateClout', upVoteCount - downVoteCount);
    },
    getForumTitle(forumId) {
      const forum = this.$store.state.forums.find((forum) => forum.id === forumId);
      return forum ? forum.title : 'Forum Not Found';
    }
  }
};
</script>

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