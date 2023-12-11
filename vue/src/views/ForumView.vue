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
        <v-text class="text-h2">Forum posts</v-text> 
        <v-text-field class="flex-1-0 ma-2 pa-2" id="postInput" v-model="inputValue" @click="navigateToFormPage" label="Create Post"></v-text-field>

        <forum-section v-bind:forum="findForum" />
        
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>


</v-main>

  <side-bar />


</template> 



<script>
import ForumSection from '../components/ForumSection.vue';
import SideBar from '../components/SideBar.vue';

export default {
    components: {
        SideBar,
        ForumSection,
    },
    computed: {
        findForum() {
            let forumId = this.$route.params.id;  
            let forum = this.$store.state.forums.find((p) => p.id == forumId);
            return forum;
        }
    },
    methods: {
      navigateToFormPage() {
        this.$router.push({ name: 'create-post' });
        
      }
    }
}
</script>

<style>


</style>