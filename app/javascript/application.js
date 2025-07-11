// Configure your import map in config/importmap.rb

// Import core Rails libraries
import "@hotwired/turbo-rails"
import "controllers"

// Import third-party libraries
import "bootstrap"

// jQuery is loaded via CDN, so import is not needed

// Font Awesome star rating system is now used instead of Raty

// Font Awesome star rating system is now used instead of Raty

// Google Maps API with Stimulus.js
window.dispatchMapsEvent = function (...args) {
  const event = document.createEvent("Events")
  event.initEvent("google-maps-callback", true, true)
  event.args = args
  window.dispatchEvent(event)
}

// Star rating initialization function
function initializeStarRatings() {
  document.querySelectorAll('.star-rating').forEach(function(element, index) {
    const score = parseFloat(element.dataset.score) || 0;
    
    // Round to nearest 0.5
    const roundedScore = Math.round(score * 2) / 2;
    element.setAttribute('data-score', roundedScore);
  });
}

document.addEventListener('DOMContentLoaded', initializeStarRatings);
document.addEventListener('turbo:load', initializeStarRatings);
document.addEventListener('turbo:render', initializeStarRatings);

document.addEventListener('DOMContentLoaded', function() {
  if (typeof google !== 'undefined' && google.maps) {
    // Google Maps API is ready
  }
}); 