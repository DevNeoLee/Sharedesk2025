// Configure your import map in config/importmap.rb

// Import core Rails libraries
import "@hotwired/turbo-rails"
import "controllers"

// Import third-party libraries
import "bootstrap"

// jQuery is loaded via CDN, so import is not needed

// Assign star image paths to window global (needs to be inserted in application.html.erb)
window.RATY_STAR_ON = window.RATY_STAR_ON || '/assets/star-on.png';
window.RATY_STAR_OFF = window.RATY_STAR_OFF || '/assets/star-off.png';
window.RATY_STAR_HALF = window.RATY_STAR_HALF || '/assets/star-half.png';

function initializeAllRaty() {
  if (typeof window.$ !== 'undefined' && typeof window.$.fn.raty !== 'undefined') {
    document.querySelectorAll('.star-rating').forEach(function(el) {
      if (!el.classList.contains('raty-initialized')) {
        const score = el.getAttribute('data-score') || 0;
        window.$(el).raty({
          readOnly: true,
          score: score,
          starOff: window.RATY_STAR_OFF,
          starOn: window.RATY_STAR_ON,
          starHalf: window.RATY_STAR_HALF,
          size: 24,
          hints: ['1 star', '2 stars', '3 stars', '4 stars', '5 stars']
        });
        el.classList.add('raty-initialized');
      }
    });
  }
}
document.addEventListener('turbo:load', initializeAllRaty);
document.addEventListener('DOMContentLoaded', initializeAllRaty);

// Google Maps API with Stimulus.js
window.dispatchMapsEvent = function (...args) {
  const event = document.createEvent("Events")
  event.initEvent("google-maps-callback", true, true)
  event.args = args
  window.dispatchEvent(event)
}

document.addEventListener('DOMContentLoaded', function() {
  if (typeof google !== 'undefined' && google.maps) {
    // Google Maps API is ready
  }
}); 