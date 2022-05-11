<template>
  <section class="section">
    <div class="columns">
      <div class="column is-2">
        <div class="menu">
          <div
            class="button is-danger is-block is-medium"
            @click="require_login"
          >
            New List
          </div>
          <p class="menu-label">
            new tags
          </p>
          <ul class="menu-list">
            <div class="tags">
              <span 
                v-for="tag in displaytag"
                :key="tag.id"
                class="tag is-light is-medium"
                @click="tagsearch(tag)"
              >
                {{ tag.name }}
              </span>
            </div>
          </ul>
        </div>
      </div>
      <div class="column is-10">
        <div class="tabs is-boxed">
          <ul>
            <li :class="{ 'is-active': isActive == 'list' }">
              <a @click="isActive = 'list'">LIST</a>
            </li>
            <li :class="{ 'is-active': isActive == 'tag' }">
              <a @click="isActive = 'tag'">TAG</a>
            </li>
            <li :class="{ 'is-active': isActive == 'search' }">
              <a @click="isActive = 'search'">SEARCH</a>
            </li>
          </ul>
        </div>
        <div class="tab-contents">
          <div class="content">
            <div v-if="isActive == 'list'">
              <ListItem
                :lists="lists"
              />
            </div>
            <div v-if="isActive == 'search'">
              <div class="field">
                <div class="control">
                  <input
                    v-model="keyword"
                    class="input"
                    type="text" 
                    placeholder="検索"
                  >
                </div>
              </div>
              <ListItem
                :lists="searchLists"
              />
            </div>
            <div v-if="isActive == 'tag'">
              <div class="tags">
                <span 
                  v-for="tag in tags"
                  :key="tag.id"
                  class="tag is-light is-danger"
                  @click="tagsearch(tag)"
                >
                  {{ tag.name }}
                </span>
              </div>
              <ListItem
                :lists="tagearchlists"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import { mapGetters, mapActions } from "vuex"
import ListItem from './conponents/listitems.vue'
export default {
  name: "ListIndex",
  components: {
    ListItem,
  },
  data() {
    return {
      isActive: 'list',
      keyword: '',
      tagearchlists: [],
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("lists", ["lists"]),
    ...mapGetters("tags", ["tags"]),
    searchLists: function() {
      var searchlists = [];
      for (var i in this.lists) {
        var list  = this.lists[i];
        if (
          list.title.indexOf(this.keyword) !== -1 || 
          list.recommend.indexOf(this.keyword) !== -1
        )
        { searchlists.push(list);}
      }
      return searchlists;
    },
    displaytag(){
      return this.tags.slice(0,30)
    },
  },
  created: function(){
    this.fetchLists();
    this.fetchTags();
  },
  methods: {
    ...mapActions("lists", ["fetchLists"]),
    ...mapActions("tags", ["fetchTags"]),
    require_login(){
      if (this.authUser) {
        this.$router.push({name: 'ListNew'})
      } else {
        this.$router.push({name: 'LoginIndex'})
        this.$notify({
          type: "warn",
          title: "ログインしてください",
        });
      }
    },
    tagsearch(searchtag){
      this.tagearchlists = []
      for (var i in this.lists) {
        var list  = this.lists[i];
        for (var i in list.tags) {
          var tag  = list.tags[i];
          if ( tag.id === searchtag.id)
          { this.tagearchlists.push(list);}
        }
      }
      this.isActive = 'tag'
    },
  }
}
</script>
<style>
.favorited {
  color:  rgb(255, 104, 129);
}
</style>
