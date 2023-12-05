<template>
  <div class="home">
    <v-app-bar :elevation="2">
      
      <v-app-bar-nav-icon><v-icon icon="$vuetify"></v-icon></v-app-bar-nav-icon>
      <v-app-bar-title>Rediquette</v-app-bar-title>
      <v-navigation drawer></v-navigation>
    </v-app-bar>
  <main-section />
  <side-bar />
  </div>
</template>

<script>
import MainSection from '../components/MainSection.vue'
import SideBar from '../components/SideBar.vue';

export default {
  components: {
    MainSection,
    SideBar
  }
};
</script>
