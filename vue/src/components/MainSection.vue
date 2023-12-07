<template>
  <v-content>
 <div style="padding-top: 20px;">
      
      <v-container>
        <div class="d-flex justify-center">
          <v-card-title class="text-h6 text-md-h5 text-lg-h4">My Posts</v-card-title>
        </div>

        <filter-bar />

        <v-row class="justify-center">
          <v-col cols="12" md="12">
            <v-row>
              <small-post class="ma-2" v-for="post in filteredPosts" :key="post.id" :post="post" />
           </v-row>
          </v-col>
        </v-row>
      </v-container>

    </div>
    
  </v-content>
</template>

<script>
import { storeKey } from 'vuex';
// import FeaturedPost from '../components/FeaturedPost.vue'
import SmallPost from '../components/SmallPost.vue'
import FilterBar from '../components/FilterBar.vue';


export default {
  components: {
    // FeaturedPost,
    SmallPost,
    FilterBar,

  },
    computed: {
        filteredPosts() {
            return this.$store.state.posts.slice().sort((a, b) => new Date(b.dateCreated) - new Date(a.dateCreated));
        }
    }
}

</script>

