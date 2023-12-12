<template>
  <v-main class="bg-grey-lighten-3">
    <v-container class="bg-grey-lighten-3">
      <v-row>

        <v-col>
          <v-sheet min-height="70vh" rounded="lg">
            <div class="custom-padding">
              <v-content>
                <div class="pb-6">
                  <v-text class="text-h4">Create a Post</v-text>
                  <p class="font-weight-bold py-4">Choose a forum to post to:</p>
                  <v-select class="py-4" label="Choose a forum"
                    :items="['Forum1', 'Forum2', 'Forum3', 'Forum4', 'Forum5', 'Forum6']"></v-select>
                  <p class="font-weight-bold py-4">Add text and an image: </p>

                  <v-window>
                    <v-window-item v-for="n in 3" :key="n" :value="n">
                      <v-container fluid>
                        <v-sheet class="mx-auto">
                          <v-form @submit.prevent>
                            <v-text-field v-model="title" label="Title" required></v-text-field>
                            <v-row>
                              <div>
                                <tiptap-rich-text-editor />
                              </div>
                            </v-row>
                            <v-row>
                              <v-file-input label="File input" variant="filled" prepend-icon="mdi-camera"></v-file-input>
                            </v-row>
                            <v-btn type="submit" block class="mt-2">Post</v-btn>
                          </v-form>

                        </v-sheet>

                      </v-container>

                    </v-window-item>
                  </v-window>
                </div>



              </v-content>
            </div>
          </v-sheet>
        </v-col>

        <v-col cols="2">
          <v-sheet rounded="lg">
            <v-list rounded="lg">
              <v-list-item v-for="n in 5" :key="n" link :title="`List Item ${n}`"></v-list-item>

              <v-divider class="my-2"></v-divider>

              <v-list-item color="grey-lighten-4" link title="Refresh"></v-list-item>
            </v-list>
          </v-sheet>
        </v-col>

      </v-row>
    </v-container>
  </v-main>
</template>

<script>
import TiptapRichTextEditor from '../components/TiptapRichTextEditor.vue';

export default {
  components: { TiptapRichTextEditor },
  data() {
    return {
      components: {
        TiptapRichTextEditor
      },
      tab: 1, // Set the initial value to 1 for the "Post" tab
    };
  },
};
</script>

<style>
.custom-padding {
  padding: 80px 60px;
}
</style>