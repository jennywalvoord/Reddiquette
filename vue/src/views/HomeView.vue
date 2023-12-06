<template>
<v-content>


  <div class="d-flex flex-wrap grey-lighten pa-24">
    <div class="flex-1-0 ma-24 pa-24">
      <main-section />
    </div>
    
    <v-navigation-drawer fixed permanent location="right">

      <div class="flex-1-0 ma-24 pa-24">
        <side-bar v-bind:forums="forums"/>
      </div>

    </v-navigation-drawer>
  </div>
</v-content>
  

</template>


<script>
import MainSection from '../components/MainSection.vue'
import SideBar from '../components/SideBar.vue';

export default {
  components: {
    MainSection,
    SideBar,
  },
  data: () => ({ drawer: null }),
};
</script>

<style>

div.home {
  flex-flow: row;
}

.main {
  display: flex;
}

</style>