// Configure your import map in config/importmap.rb

// Import core Rails libraries
import "@hotwired/turbo-rails"
import "controllers"

// Import third-party libraries
import "bootstrap"

// jQuery는 CDN으로 로드되므로 import 불필요

// Import custom JavaScript (if needed)
// import "./site"

// Raty Star Rating Controller는 app/javascript/controllers/raty_controller.js에 정의됨

// Legacy raty initialization for backward compatibility
function initializeAllRaty() {
  if (typeof window.$ !== 'undefined' && typeof window.$.fn.raty !== 'undefined') {
    document.querySelectorAll('.star-rating:not(.raty-initialized)').forEach(function(el) {
      const score = el.getAttribute('data-score') || 0
      const imagePath = (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') 
        ? '/assets/' 
        : '/images/'
      
      try {
        window.$(el).raty({
          readOnly: true,
          score: score,
          starOff: imagePath + 'star-off.png',
          starOn: imagePath + 'star-on.png',
          starHalf: imagePath + 'star-half.png',
          size: 24,
          hints: ['1 star', '2 stars', '3 stars', '4 stars', '5 stars']
        })
        el.classList.add('raty-initialized')
      } catch (error) {
        console.error('Error initializing Raty for element:', error)
      }
    })
  } else {
    setTimeout(initializeAllRaty, 100)
  }
}

// Initialize on page load
document.addEventListener('turbo:load', initializeAllRaty)
document.addEventListener('DOMContentLoaded', initializeAllRaty)

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