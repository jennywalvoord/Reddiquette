<template>

<v-main>
  <v-text class="text-h2">Forum Posts</v-text>

  <v-sheet
              class="d-flex align-center justify-center flex-wrap text-center mx-auto"
              elevation="4"
              fluid
              rounded
              max-width="600"
              width="100%"
            >
              <v-text-field class="flex-1-0 ma-2 pa-2" id="postInput" v-model="inputValue" @click="navigateToFormPage" label="Create Post"></v-text-field>
            </v-sheet>
  <forum-section v-bind:forum="findForum" />

</v-main>

  <side-bar />


  <!-- <main class="d-flex flex-wrap grey-lighten pa-24">
    <div class="ma-24 pa-24">
      <v-container class="d-flex">
        <v-row>
          <v-col cols="12" md="12">
            <v-sheet
              class="d-flex align-center justify-center flex-wrap text-center mx-auto"
              elevation="4"
              fluid
              rounded
              max-width="600"
              width="100%"
            >
              <v-text-field class="flex-1-0 ma-2 pa-2" id="postInput" v-model="inputValue" @click="navigateToFormPage" label="Create Post"></v-text-field>
            </v-sheet>
            
            <forum-section v-bind:forum="findForum" />
          </v-col>
        </v-row>
      </v-container>
    </div>

    <v-navigation-drawer fixed permanent location="right">
      <div class="ma-24 pa-24">
        <side-bar v-bind:forums="forums" />
      </div>
    </v-navigation-drawer>
  </main>-->
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