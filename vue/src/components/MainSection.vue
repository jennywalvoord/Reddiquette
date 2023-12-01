<template>
    <div>
        <featured-article />
        <small-article />
        <side-bar />
    </div>
</template>

<script>
import FeaturedArticle from '../components/FeaturedArticle.vue'
import SmallArticle from '../components/SmallArticle.vue'
import SideBar from '../components/SideBar.vue'
export default {
    components: {
        FeaturedArticle,
        SmallArticle,
        SideBar,
    }

}

</script>

