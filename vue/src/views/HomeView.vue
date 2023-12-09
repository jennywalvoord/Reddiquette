<template>

    <v-main class="bg-grey-lighten-4">
      <v-container>
        <v-row>
          

          <v-col>
            <v-sheet
            min-height="70vh"
            rounded="lg"
            class="ma-4 pa-4"
            >
            <v-text class="text-h2">My Posts</v-text>
            <v-slide-group show-arrows>
                <v-slide-group-item
                  v-for="post in filteredPosts"
                  :key="post.id"
                >
                <small-post 
                  :post="post" 
                  class="ma-3"
                  rounded
                  width="250"/>
                </v-slide-group-item>
              </v-slide-group>
          </v-sheet>
          </v-col>
        </v-row>
      </v-container>

      
    </v-main>
    
    <side-bar />

    <v-footer
      app
      height="72"
    >
      <v-text-field
        bg-color="grey-lighten-1"
        class="overflow-hidden"
        density="compact"
        flat
        hide-details
        rounded="pill"
        variant="solo-filled"
      ></v-text-field>
    </v-footer>
   
</template>



<!-- <template>
  
  <div class="d-flex flex-wrap grey-lighten pa-24">
    <div class="ma-24 pa-24">
      <div class="filter-bar-wrapper">
        <filter-bar />
      </div>
      <main-section />
    </div>

      <v-navigation-drawer fixed permanent location="right">
      <div class="ma-24 pa-24">
        <side-bar v-bind:forums="forums"/>
      </div>
    </v-navigation-drawer>
    
  </div>
</template>

<script>
import MainSection from '../components/MainSection.vue';
import SideBar from '../components/SideBar.vue';
import FilterBar from '../components/FilterBar.vue'

export default {
  components: {
    MainSection,
    SideBar,
    FilterBar
  },
  data: () => ({ drawer: null }),
};
</script> -->

<script>
import SmallPost from '../components/SmallPost.vue'
import SideBar from '../components/SideBar.vue'

export default {
  components: {
  SmallPost,
    SideBar,
  },
  computed: {
        filteredPosts() {
            return this.$store.state.posts.slice().sort((a, b) => new Date(b.dateCreated) - new Date(a.dateCreated));
        }
    },
  data: () => ({ drawer: null }),
};
</script> 


