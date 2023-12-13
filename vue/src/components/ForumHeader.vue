<template>
    <div class="well">
        <div>

        </div>
        <div>
            <h3 v-bind:to="{ name: 'forum-view', params: { id: forums.forumId } }">
                {{ forums.forumTitle }}
                <!-- //<router-link  v-bind:to="{ name: 'forum-view', params: {id: forums.forumId}}">{{forums.title}}</router-link> -->
            </h3>
            <p v-bind:to="{ name: 'forum-view', params: { id: forums.forumId } }">{{ forums.forumDescription }}</p>


        </div>
    </div>
</template>
<script>

export default {
    props: ['forums']
   
}

</script>