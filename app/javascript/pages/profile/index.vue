<template>
  <div class="section"> 
    <div class="tile is-ancestor">
      <div class="tile is-vertical is-8">
        <div class="tile is-parent">
          <div class="tile is-child">
            <div class="tabs">
              <ul>
                <li :class="{ 'is-active': isActive == 'list' }">
                  <a @click="isActive = 'list'">MY LIST</a>
                </li>
                <li :class="{ 'is-active': isActive == 'favorite' }">
                  <a @click="isActive = 'favorite'">MY FAVORITE</a>
                </li>
              </ul>
            </div>
            <div class="tab-contents">
              <div class="content">
                <div v-if="isActive == 'list'">
                  <ListItem 
                    :lists="userlists"
                  />
                </div>
                <div v-if="isActive == 'favorite'">
                  <ListItem 
                    :lists="favorites"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="tile is-parent">
        <div class="tile is-child">
          <div class="tabs">
            <ul>
              <li class="is-active">
                <a>PROFILE</a>
              </li>
            </ul>
          </div>
          <div class="content">
            <ProfileEdit />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import ProfileEdit from './edit.vue'
import ListItem from '../list/conponents/listitems.vue'

export default {
  name: "ProfileIndex",
  components: {
    ProfileEdit,
    ListItem,
  },
  data() {
    return {
      isActive: 'list'
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("lists", ["lists"]),
    ...mapGetters("favorites", ["favorites"]),
    userlists() {
    return this.lists.filter(
      list => list.user_id === this.authUser.id)
    },
  },
  methods: {
    ...mapActions("lists", ["fetchLists",]),
    ...mapActions("favorites", ["fetchmyFavorites"]),
  },
  created () {
    this.fetchLists();
    this.fetchmyFavorites();
  },
}
</script>

<style scoped>
</style>
