<template>
  <div>
    <section class="hero is-white is-medium">
      <div class="hero-body">
        <div class="container">
          <div
            class="columns  is-vcentered"
            data-aos="fade-right"
          >
            <div class="column is-7">
              <h1 class="title is-1 mb-6">
                <a class="border">Share Tech Tube</a>
              </h1>
              <div class="subtitle">
                <p>ShareTechTubeは</p>
                <p>プログラミングに特化したyoutube共有プラットフォームです</p>
              </div>
              <div class="buttons">
                <template v-if="!authUser">
                  <router-link
                    :to="{ name: 'LoginIndex' }"
                    class="nav-link button is-danger"
                  >
                    LOGIN
                  </router-link>
                  <router-link
                    :to="{ name: 'RegisterIndex' }"
                    class="nav-link button is-danger"
                  >
                    NEW ACCOUNT
                  </router-link>
                </template>
                <template v-else>
                  <router-link
                    :to="{ name: 'ListIndex' }"
                    class="nav-link button is-danger"
                  >
                    LISTS
                  </router-link>
                  <router-link
                    :to="{ name: 'ListNew' }"
                    class="nav-link button is-danger"
                  >
                    LIST NEW
                  </router-link>
                </template>
              </div>
            </div>
            <div class="column">
              <figure class="column is-8">
                <img src="../../../assets/images/desktop.png">
              </figure>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="hero is-danger is-medium">
      <div class="hero-body">
        <div class="container">
          <h1
            class="title has-text-centered"
            data-aos="fade-down"
          >
            HOW TO USE
          </h1>
          <hr
            class="mb-6"
            data-aos="fade-down"
          >
          <div
            class="columns"
            data-aos="fade-down"
          >
            <div class="column">
              <h1 class="title is-2">
                1
              </h1>
              <h2 class="title is-4">
                YOUTUBEで勉強しよう
              </h2>
              <div class="subtitle">
                <p>まずはyoutubeで勉強をしてみよう!</p>
                <p>きっと気になる動画がたくさんあるはず！</p>
              </div>
              <figure class="column is-half is-offset-one-quarter">
                <img src="../../../assets/images/human1.png">
              </figure>
            </div>
            <div class="column">
              <h1 class="title is-2">
                2
              </h1>
              <h2 class="title is-4">
                知見を共有しよう
              </h2>
              <div class="subtitle">
                <p>いい動画は見つかった？</p>
                <p>動画と一緒におすすめポイントや学んだことを共有してみよう！!</p>
              </div>
              <h3 class="subtitle" />
              <figure class="column is-half is-offset-one-quarter">
                <img src="../../../assets/images/human2.png">
              </figure>
            </div>
            <div class="column">
              <h1 class="title is-2">
                ...next
              </h1>
              <h2 class="title is-4">
                欲しい情報がすぐ見つかる
              </h2>
              <div class="subtitle">
                <p>誰かが参考にしたならあなたの役にも立つ！</p>
                <p>いますぐ投稿を見てみよう！!</p>
              </div>
              <figure class="column is-half is-offset-one-quarter">
                <img src="../../../assets/images/human3.png">
              </figure>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="hero is-white is-medium">
      <div class="hero-body">
        <div class="container">
          <h1
            class="title has-text-centered"
            data-aos="fade-down"
          >
            PICKUP LIST
          </h1>
          <hr
            class="mb-6"
            data-aos="fade-down"
          >
          <div data-aos="fade-down">
            <ListItem
              :lists="limitlists"
            />
          </div>
        </div>
      </div>
    </section>
    <section class="hero is-danger">
      <div class="hero-body">
        <div class="container">
          <div class="columns  is-vcentered">
            <div
              class="column"
              data-aos="fade-left"
            >
              <figure class="image column column is-6 is-offset-4 has-text-right">
                <img src="../../../assets/images/rocket_woman.png">
              </figure>
            </div>
            <div
              class="column is-8"
              data-aos="fade-down"
            >
              <h1 class="titled title is-1 mb-6">
                Let's Lerning By Youtube
              </h1>
              <h2 class="subtitled subtitle">
                youtubeで勉強していきましょう!
              </h2>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script>
import { mapGetters, mapActions } from "vuex"
import ListItem from '../list/conponents/listitems.vue'

export default {
  name: "AboutIndex",
  components: {
    ListItem,
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("lists", ["lists"]),
    limitlists() {
      return this.lists.slice(0,3)
    }
  },
  methods: {
    ...mapActions("lists", [
      "fetchLists",
    ]),
  },
  created () {
    this.fetchLists();
  },
}
</script>
<style scoped>
.border {
  border-bottom: solid;
  border-color: #ff5a5a;
  border-width: 5px;
}
</style>

