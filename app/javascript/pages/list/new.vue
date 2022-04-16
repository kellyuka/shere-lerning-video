<template>
  <section>
    <h2>リスト作成</h2>
    <SearchList 
      :authuser="authUser"
    />
  </section>
</template>

<script>
import SearchList from './conponents/youtube/SearchList.vue'
import { mapGetters } from "vuex"

export default {
  name: "ListNew",
  components: {
    SearchList,
  },
  data() {
    return {
    }
  },
  computed: {
      ...mapGetters("users", ["authUser"]),
  }
}
</script>
