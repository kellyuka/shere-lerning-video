<template>
<div class="section"> 
  <div class="tile is-ancestor">
    <div class="tile is-vertical is-8">
        <div class="tile is-parent">
          <div class="tile is-child">
            <div class="content">
              <p class="subtitle">LIST</p>
            <article 
              v-for="list in lists" 
              :key="list.id"
              class="media box" 
            >
              <div class="media-content">
                <div class="content">
                  <router-link
                    :to="'/lists/'+list.id"
                    class=""
                  >
                  <h4>{{ list.title }} </h4>
                  </router-link>
                  <p>
                    {{ list.recommend }}
                  </p>
                  <ul>
                    <span 
                      v-for="tag in list.tags"
                      :key="tag.id"
                      class="tag is-light is-danger"
                    >
                      {{ tag.name }}
                    </span>
                  </ul>
                  <div class="columns is-multiline">
                    <div
                    v-for="video in list.videos"
                    :key="video.id"  
                    class="column is-3"
                    >
                      <lite-youtube
                        :videoid="video.videoid"
                        params="rel=0"
                      />
                    </div>
                      <!-- style="width:320px"  -->
                  </div>
                </div>
              </div>
              <div class="media-right">
                <span class="has-text-grey-light"><i class="fa fa-comments" /> 1</span>
              </div>
            </article>
            </div>
          </div>
        </div>
    </div>
    <div class="tile is-parent">
      <div class="tile is-child">
        <div class="content">
          <p class="subtitle">PROFILE</p>
          <ProfileEdit/>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import ProfileEdit from './edit.vue'
import { mapGetters, mapActions } from "vuex"

export default {
  name: "ProfileIndex",
  components: {
    ProfileEdit,
  },
  data() {
    return {
    }
  },
  computed: {
    ...mapGetters("lists", ["lists"]),
    ...mapGetters("users", ["authUser"]),
  },
  methods: {
    ...mapActions("lists", [
      "userlists",
    ]),
  },
  created () {
    this.userlists();
  },
}
</script>

<style scoped>
</style>
