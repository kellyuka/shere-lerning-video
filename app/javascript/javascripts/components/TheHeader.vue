<template>
<nav class="navbar">
  <div class="container">
    <div class="navbar-brand">
      <a class="navbar-item has-text-danger	" href="#">
        <img class="image" src="" alt="" width="96px">
        <strong>ShareTechTube</strong>
      </a>
      <a class="navbar-burger" role="button" aria-label="menu" aria-expanded="false">
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>
    <div id="my-menu" class="navbar-menu">
      <div class="navbar-start">
        <a class="navbar-item" href="#">About</a>
        <a class="navbar-item" href="#">Index</a>
        <a class="navbar-item" href="#">Category</a>
        <a class="navbar-item" href="#">Tag</a>
      </div>
      <div class="navbar-item">
        <div class="field has-addons">
          <div class="control">
            <input class="input" type="search" placeholder="Search" aria-label="Search">
          </div>
          <div class="control">
            <button class="button" type="submit">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" style="width: 24px;height: 24px">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
              </svg>
            </button>
          </div>
        </div>
      </div>
        <div class="navbar-item">
          <button class="button is-danger">ログイン</button>
        </div>
    </div>
  </div>
</nav>
</template>

<script>
export default {
  name: "Header",
  data() {
    return {
    }
  }
}
</script>

<style scoped>
.navbar-menu a:hover{
  color:red
}
</style>
