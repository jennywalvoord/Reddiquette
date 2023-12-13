<template>

    <v-main class="bg-grey-lighten-4">
      <v-container>
        <v-row>
          <v-col>
            <v-sheet
            min-height="100vh"
            rounded="lg"
            class="ma-4 pa-4"
            >
            <v-text class="text-h4">Recent Posts</v-text>
            <v-slide-group show-arrows>
                <v-slide-group-item
                  v-for="post in filteredPosts"
                  :key="post.id"
                >
                <small-post 
                  :post="post" 
                  
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



<script>
import SmallPost from '../components/SmallPost.vue'
import SideBar from '../components/SideBar.vue'
import ForumService from '../services/ForumService';
import PostService from '../services/PostService';

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
  created() {
    ForumService.getForums().then(response => {
    this.$store.commit("SET_FORUMS", response.data);
    }  
    );
    PostService.getPosts().then(response =>{
    this.$store.commit("SET_POSTS", response.data);
    }  
    );
  }, 
  // createdPOSTS() {
  //   PostService.getPosts().then(response =>{
  //   this.$store.commit("SET_POSTS", response.data);
  //   }  
  //   );
  // },     
  
};
</script> 


