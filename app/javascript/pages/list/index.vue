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
        <div class="tabs">
          <ul>
            <li class="is-active">
              <a>LIST</a>
            </li>
          </ul>
        </div>
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
                <a href="#">@red</a>
                <router-link
                  :to="'/lists/'+list.id"
                  class=""
                >
                  <h4>{{ list.title }} </h4>
                </router-link>
                <p>
                  {{ list.recommend }}
                </p>
                
                <div class="tags">
                  <ion-icon
                    name="pricetag-outline"
                    class="pr-2"
                  />
                  <span 
                    v-for="tag in list.tags"
                    :key="tag.id"
                    class="tag is-light is-danger"
                  >
                    {{ tag.name }}
                  </span>
                </div>
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
                </div>
              </div>
            </div>
            <div class="media-right">
              <span class="icon-text">
                <span class="icon">
                  <ion-icon name="chatbox-ellipses-outline" />
                </span>
                {{ list.comments.length }}
                <span class="icon">
                  <ion-icon name="heart-outline" />
                </span>
                {{ list.comments.length }}
              </span>
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
    ...mapGetters("users", ["authUser"]),
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
