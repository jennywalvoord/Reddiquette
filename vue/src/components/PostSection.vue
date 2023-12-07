<template>
  <v-content>
    <v-sheet class="citation">
        <h4>{{ getForumTitle(post.forumId) }}</h4>
        <v-row>
          <v-col><h6>Posted User:{{ getUserName(post.userId) }}</h6></v-col>
          <v-col><h6>Posted: {{ post.dateCreated }}</h6></v-col>
        </v-row>
    </v-sheet>
    <v-card class="postDetails">
      <v-container class="my-5">
        <div>
          <v-img :width="300" :height="200" aspect-ratio="16/9" cover :src="post.image"></v-img>
          <v-card-title>{{ post.title }}</v-card-title>
          <v-card-text>{{ post.body }} </v-card-text>
        </div>
        <div>
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
        </div>
        <textarea id="textArea" name="story" rows="5" cols="33">
        </textarea>
      </v-container>
    </v-card>

  </v-content>
</template>
    
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