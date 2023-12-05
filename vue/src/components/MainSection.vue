<template>
    <div>
        <v-container class="my-5">
        <v-layout row>
          <v-flex xs12 md6>
            <featured-post />
          </v-flex>
        </v-layout>
      </v-container>
      
      <v-container class="my-5">
        <v-layout row>
          <v-flex xs12 md>
            <small-post v-for="post in filteredPosts" :key="post.id" :post="post" />

          </v-flex>
        </v-layout>
      </v-container>
    </div>
</template>

<script>
import { storeKey } from 'vuex';
import FeaturedPost from '../components/FeaturedPost.vue'
import SmallPost from '../components/SmallPost.vue'

export default {
    components: {
        FeaturedPost,
        SmallPost,
    },
    computed: {
        filteredPosts() {
            return this.$store.state.posts.slice().sort((a, b) => new Date(b.dateCreated) - new Date(a.dateCreated));
        }
    }
}

</script>

