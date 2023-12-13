<template>

<v-main>
  <v-container class="bg-grey-lighten-4">
    <v-row>
      <v-col>
        <v-sheet
        min-height="70vh"
        rounded="lg"
        class="ma-4 pa-4"
        >
        <v-text class="text-h4">{{ findForumName }}</v-text> 
        <v-text-field class="flex-1-0 ma-2 pa-2" id="postInput" v-model="inputValue" @click="navigateToFormPage" label="Create Post"></v-text-field>

        <forum-section v-bind:forum="findForum" />
        
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
  <side-bar :isAppMode="isAppMode" />


</v-main>



</template> 



<script>
import ForumSection from '../components/ForumSection.vue';
import SideBar from '../components/SideBar.vue';
import ForumService from '../services/ForumService';
import PostService from '../services/PostService';
import CommentService from '../services/CommentService';
export default {
    components: {
        SideBar,
        ForumSection,
    },
    computed: {
        findForum() {
            let forumId = this.$route.params.id;  
            let forum = this.$store.state.forums.find((p) => p.forumId == forumId);
            return forum;
        },
        findForumName() {
            let forumId = this.$route.params.id;  
            let forum = this.$store.state.forums.find((p) => p.forumId == forumId);
            return forum.forumTitle
        }

    },
    methods: {
      navigateToFormPage() {
        this.$router.push({ name: 'create-post' });
        
      }
    },created() {
    ForumService.getForums().then(response => {
    this.$store.commit("SET_FORUMS", response.data);
    }  
    );
    PostService.getPosts().then(response =>{
    this.$store.commit("SET_POSTS", response.data);
    }  
    );
    CommentService.getComments().then(response =>{
    this.$store.commit("SET_COMMENTS", response.data);
    }  
    );
  },
}
</script>

<style>


</style>