<template>
  <section class="section ">
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
                <!-- <h4>Bulma: How do you center a button in a box?Bulma: How do you center a button in a box?Bulma: How do you center a button in a box?Bulma: How do you center a button in a box?Bulma: How do you center a button in a box?</h4> -->
                <h4>
                  {{ list.title }} 
                  <span class="tag">Customers</span>
                </h4>
                <p>
                  <a href="#">@red</a>
                  {{ list.recommend }}
                </p>
                <iframe
                  width="320"
                  height="180"
                  :src="'https://www.youtube.com/embed/videoseries?controls=0&amp;list='+ list.playlistid "
                  title="YouTube video player"
                  frameborder="0"
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                  allowfullscreen
                />
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
    //vuexgetterから、tasksをtasksとして取得 
    ...mapGetters("lists", ["lists"]),
  },
  created () {
    this.fetchLists();
  },
  methods: {
    ...mapActions("lists", [
      "fetchLists",
    ]),
  },
}
</script>
