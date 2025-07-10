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

// Global queue for toastr messages
window.toastrQueue = [];

// Function to process queued messages
function processToastrQueue() {
  // Check localStorage for persisted messages
  const storedMessages = JSON.parse(localStorage.getItem('toastrQueue') || '[]');
  if (storedMessages.length > 0) {
    console.log('Found stored messages in localStorage:', storedMessages);
    storedMessages.forEach(function(item) {
      if (item.type && item.message) {
        console.log('Showing stored message:', item.type, item.message);
        window.toastr[item.type](item.message);
      }
    });
    localStorage.removeItem('toastrQueue');
  }
  
  // Process current queue
  if (window.toastrQueue && window.toastrQueue.length > 0) {
    console.log('Processing queued messages:', window.toastrQueue);
    window.toastrQueue.forEach(function(item) {
      if (item.type && item.message) {
        console.log('Showing queued message:', item.type, item.message);
        window.toastr[item.type](item.message);
      }
    });
    window.toastrQueue = [];
  } else {
    console.log('No queued messages to process');
  }
}

// Load jQuery UI and Toastr after jQuery is available
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
    
    // Load toastr dynamically after jQuery is loaded
    const toastrScript = document.createElement('script');
    toastrScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js';
    toastrScript.onload = function() {
      if (typeof window.toastr !== 'undefined') {
        console.log('Toastr loaded successfully');
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
        
        // Process queued messages immediately
        processToastrQueue();
        
        // Additional checks for queued messages (for OAuth redirects)
        setTimeout(processToastrQueue, 500);
        setTimeout(processToastrQueue, 1000);
        setTimeout(processToastrQueue, 2000);
      } else {
        console.error('Toastr failed to load');
      }
    };
    toastrScript.onerror = function() {
      console.error('Failed to load toastr script');
    };
    document.head.appendChild(toastrScript);
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