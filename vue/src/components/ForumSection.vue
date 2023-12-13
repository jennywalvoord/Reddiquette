<template>
  <div style="padding: 12px" class="text-center">


    <v-chip class="ma-2" color="primary" label v-on:click="this.areFilteringByDate = true">
      <i class="fa-solid fa-star pr-2"></i>
      Recent
    </v-chip>

    <v-chip class="ma-2" color="cyan" label v-on:click="this.areFilteringByDate = false">
      <i class="fa-solid fa-fire pr-2"></i>
      Popular
    </v-chip>
  </div>

  <v-slide-group show-arrows>
    <v-slide-group-item v-for="post in postFilter" :key="post.id">
      <small-post :post="post" class="ma-3" rounded width="250" />
    </v-slide-group-item>
  </v-slide-group>
</template>

<script>

import { storeKey } from 'vuex';
import SmallPost from '../components/SmallPost.vue';
import FilterBar from './FilterBar.vue';

export default {
  data: function () {
    return {
      areFilteringByDate: true
    }
  },
  props: ["forum"],
  components: {
    SmallPost,
  },
  methods: {
    filteredByDate() {
      let forumId = this.forum.forumId;
      let posts = this.$store.state.posts.filter((p) => p.forumId === forumId);
      posts.sort((a, b) => new Date(b.dateCreated) - new Date(a.dateCreated));
      return posts;
    },
    filteredByClout() {
      let forumId = this.forum.forumId;
      let posts = this.$store.state.posts.filter((p) => p.forumId === forumId);

      function compareClout(a, b) {
        return a.clout - b.clout;
      }
      posts.sort()
      posts.sort(compareClout)
      posts.reverse()
      return posts;
    },
  },
  computed: {
    postFilter() {
      if (this.areFilteringByDate) { return (this.filteredByDate()) }
      else { return (this.filteredByClout()) }
    },
  }
}

</script>

















