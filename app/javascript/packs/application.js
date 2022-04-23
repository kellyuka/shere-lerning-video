// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bulma/css/bulma.min';
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../javascripts/application.js'
import "packs/youtube/lite-yt-embed.css"
import "packs/youtube/lite-yt-embed.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
