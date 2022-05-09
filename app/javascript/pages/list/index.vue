<template>
  <section class="section">
    <div class="columns">
      <div class="column is-2">
        <div
          class="button is-danger is-block is-alt is-medium"
          @click="require_login"
        >
          New List
        </div>
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
        <ListItem
          :lists="lists"
        />
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
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("lists", ["lists"]),
  },
  created () {
    this.fetchLists();
  },
  methods: {
    ...mapActions("lists", ["fetchLists"]),
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
  }
}
</script>
<style>
.favorited {
  color:  rgb(255, 104, 129);
}
</style>
