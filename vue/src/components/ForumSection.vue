<template>
  <v-content>
    <v-container class="my-5">
      <v-layout row wrap>
        <v-flex xs12 md6 lg4 v-for="post in filteredPosts" :key="post.id">
          <small-post :post="post" />
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>
<script>
import { storeKey } from 'vuex';
import SmallPost from '../components/SmallPost.vue';
export default {
  props: ["forum"],
  components: {
    SmallPost,
  },
  computed: {
    filteredPosts() {
      let forumId = this.forum.id;
    let posts = this.$store.state.posts.filter((p) => p.forumId === forumId);
    posts.sort((a, b) => new Date(b.dateCreated) - new Date(a.dateCreated));
    return posts;
    }
  }
}
</script>

















