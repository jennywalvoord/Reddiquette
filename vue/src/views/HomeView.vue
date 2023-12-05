<template>
  <div class="home">
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

<style>
div.home {
  flex-flow: row;
}

</style>