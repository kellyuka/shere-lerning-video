<template>
  <section class="section">
    <div class="columns">
      <div class="column is-2">
        <router-link
          :to="{ name: 'ListNew' }"
          class="button is-danger is-block is-alt is-medium"
        >
          New List
        </router-link>
        <div class="menu">
          <p class="menu-label">
            Tags
          </p>
          <ul class="menu-list">
            <li><span class="tag is-primary is-medium ">Dashboard</span></li>
            <li><span class="tag is-link is-medium ">Customers</span></li>
            <li><span class="tag is-light is-danger is-medium ">Authentication</span></li>
            <li><span class="tag is-dark is-medium ">Payments</span></li>
            <li><span class="tag is-success is-medium ">Transfers</span></li>
            <li><span class="tag is-warning is-medium ">Balance</span></li>
            <li><span class="tag is-medium ">Question</span></li>
          </ul>
        </div>
      </div>
      <div class="column is-10">
        <div class="box content">
          <article 
            v-for="list in lists" 
            :key="list.id"
            class="media" 
          >
            <div class="media-left">
              <img
                width="64"
                height="64"
                src="/assets/canvas.jpg"
              >
            </div>
            <div class="media-content">
              <div class="content">
                <router-link
                  :to="'/lists/'+list.id"
                  class=""
                >
                  <h4>{{ list.title }} </h4>
                </router-link>
                <span class="tag">Customers</span>
                <p>
                  <a href="#">@red</a>
                  {{ list.recommend }}
                </p>
                <div class="columns is-multiline">
                  <lite-youtube
                    v-for="video in list.videos" 
                    :key="video.id"
                    :videoid="video.videoid"
                    style="width:320px" 
                    params="rel=0"
                  />
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
  </section>
</template>
<script>
import { mapGetters, mapActions } from "vuex"
export default {
  name: "ListIndex",
  computed: {
    ...mapGetters("lists", ["lists"]),
  },
  created () {
    this.fetchLists();
  },
  methods: {
    ...mapActions("lists", [
      "fetchLists",
    ]),
  }
}
</script>
