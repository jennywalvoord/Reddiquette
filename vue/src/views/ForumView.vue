<template>

<v-main class="bg-grey-lighten-3">
  <v-container >
    <v-row>
      <v-col>
        <v-sheet
        min-height="100vh"
        rounded="lg"
        class="ma-2 pa-4"
        >
        <v-text class="text-h4">{{ findForumName }}</v-text> 
      <hr style="border-top: 3px solid #ff4500">


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
    },
    created() {
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