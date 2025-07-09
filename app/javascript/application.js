// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Import jQuery FIRST and make it globally available
import jQuery from "jquery"
window.$ = window.jQuery = jQuery

// Import Bootstrap
import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap

// Import Popper.js
import * as Popper from "@popperjs/core"
window.Popper = Popper

// Import Toastr (using traditional script loading)
import "toastr"

// Load jQuery UI after jQuery is available
document.addEventListener('DOMContentLoaded', function() {
  // Load jQuery UI dynamically
  if (typeof window.$ !== 'undefined') {
    import("jquery-ui").then(() => {
      // Check if datepicker is available
      if (typeof window.$.fn.datepicker !== 'undefined') {
        // Re-initialize any existing datepicker elements
        $('.datepicker').datepicker();
      }
    }).catch(error => {
      console.error('Error loading jQuery UI:', error);
    });
  }
});

// Toastr configuration
document.addEventListener('DOMContentLoaded', function() {
  if (typeof window.toastr !== 'undefined') {
    window.toastr.options = {
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
  }
});

// Import FontAwesome
import "@fortawesome/fontawesome-free"

// Import custom JavaScript
// import "./site"

// Import jQuery Raty after jQuery is loaded
document.addEventListener('DOMContentLoaded', function() {
  if (typeof window.$ !== 'undefined') {
    import("./jquery.raty");
  }
});

// Google Maps API with Stimulus.js
window.dispatchMapsEvent = function (...args) {
  const event = document.createEvent("Events")
  event.initEvent("google-maps-callback", true, true)
  event.args = args
  window.dispatchEvent(event)
}

// Ensure dispatchMapsEvent is available globally
document.addEventListener('DOMContentLoaded', function() {
  if (typeof google !== 'undefined' && google.maps) {
    // Google Maps API is ready
  }
}); 