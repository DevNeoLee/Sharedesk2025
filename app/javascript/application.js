// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Import jQuery and make it globally available
import jQuery from "jquery"
window.$ = window.jQuery = jQuery

// Import Bootstrap
import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap

// Import Popper.js
import * as Popper from "@popperjs/core"
window.Popper = Popper

// Import jQuery UI
import "jquery-ui-dist"

// Import Toastr
import toastr from "toastr"
window.toastr = toastr

// Import FontAwesome
import "@fortawesome/fontawesome-free"

// Import custom JavaScript
import "./site"

// Import jQuery Raty
import "./jquery.raty"

// Google Maps API with Stimulus.js
window.dispatchMapsEvent = function (...args) {
  const event = document.createEvent("Events")
  event.initEvent("google-maps-callback", true, true)
  event.args = args
  window.dispatchEvent(event)
}

// Toastr configuration
toastr.options = {
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "10000",
  "hideDuration": "1000",
  "timeOut": "3000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
} 