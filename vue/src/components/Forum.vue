<template>
    <v-content>
      <div class="well">
        <div>
          <!-- Your forum component content here -->
        </div>
        <div>
          <h3>
            <router-link
              v-bind:to="{ name: 'forum-view', params: { id: forum.id }}"
            >
              {{ forum.title }}
            </router-link>
          </h3>
          <!-- Pass sortBy prop dynamically based on user interaction -->
          <forum-section :forum="forum" :sortBy="sortBy" />
        </div>
      </div>
    </v-content>
  </template>
  
  <script>
  import ForumSection from './ForumSection.vue';
  
  export default {
    props: ['forum'],
    components: {
      ForumSection,
    },
    data() {
      return {
        sortBy: 'date', // or 'clout'
      };
    },
  };
  </script>