<template>
  <div>
    <label class="label">再生リスト</label>
    <button @click="searchLists">
      検索
    </button>
    <div v-show="results">
      <div class="columns is-multiline">
        <div
          v-for="(list) in results"
          :key="list.id"
          class="column is-2"
          @click="select(list.id)"
        >
          <img :src="list.snippet.thumbnails.medium.url">
          <h2 class="subtitle">
            {{ list.snippet.title }}
          </h2>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex"

export default {
  name: "SearchList",
  props: {
    channelid:{
      type: String,
      required: true
    }
  },
  data: function() {
    return {
      results: "",
    };
  },
  methods: {
    ...mapActions("youtube", ["searchplayLists"]),
    searchLists() {
      this.searchplayLists(this.channelid)
        .then(res => { this.results = res.data.items })
        .catch(function(err) {
          alert("検索に失敗しました。")
        })
    },
    select(id) {
      this.$emit('select',id)
    },
  }
};
</script>
<style scoped>
</style>
