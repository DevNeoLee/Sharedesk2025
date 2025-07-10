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

// 전역 raty 초기화 함수
window.initializeRatyGlobally = function() {
  console.log('[Raty Debug] initializeRatyGlobally called');
  
  if (typeof window.$ !== 'undefined' && typeof window.$.fn.raty !== 'undefined') {
    console.log('[Raty Debug] jQuery and Raty are available');
    
    const starElements = document.querySelectorAll('.star-rating:not(.raty-initialized)');
    console.log('[Raty Debug] Found', starElements.length, 'star-rating elements to initialize');
    
    // 모든 star-rating 클래스를 가진 요소들을 초기화
    starElements.forEach(function(el, index) {
      const score = el.getAttribute('data-score') || 0
      const imagePath = '/assets/'
      
      console.log(`[Raty Debug] Initializing element ${index + 1}:`, {
        element: el,
        score: score,
        imagePath: imagePath,
        starOff: imagePath + 'star-off.png',
        starOn: imagePath + 'star-on.png',
        starHalf: imagePath + 'star-half.png'
      });
      
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
        console.log(`[Raty Debug] Successfully initialized element ${index + 1}`);
      } catch (error) {
        console.error(`[Raty Debug] Error initializing Raty for element ${index + 1}:`, error)
      }
    })
    
    console.log('[Raty Debug] Global initialization completed');
  } else {
    console.log('[Raty Debug] jQuery or Raty not available yet:', {
      jquery: typeof window.$,
      raty: typeof window.$.fn?.raty
    });
    setTimeout(window.initializeRatyGlobally, 200)
  }
}

// 프로덕션에서 더 안정적인 raty 초기화
window.ensureRatyInitialized = function() {
  console.log('[Raty Debug] ensureRatyInitialized called');
  let attempts = 0;
  const maxAttempts = 10;
  
  function tryInitialize() {
    console.log(`[Raty Debug] Attempt ${attempts + 1}/${maxAttempts}`);
    
    if (typeof window.$ !== 'undefined' && typeof window.$.fn.raty !== 'undefined') {
      console.log('[Raty Debug] Dependencies available, calling initializeRatyGlobally');
      window.initializeRatyGlobally();
    } else {
      console.log('[Raty Debug] Dependencies not available:', {
        jquery: typeof window.$,
        raty: typeof window.$.fn?.raty
      });
      
      if (attempts < maxAttempts) {
        attempts++;
        console.log(`[Raty Debug] Retrying in 300ms (attempt ${attempts}/${maxAttempts})`);
        setTimeout(tryInitialize, 300);
      } else {
        console.warn('[Raty Debug] Raty initialization failed after maximum attempts');
      }
    }
  }
  
  tryInitialize();
}

// Legacy raty initialization for backward compatibility
function initializeAllRaty() {
  console.log('[Raty Debug] Legacy initializeAllRaty called');
  window.initializeRatyGlobally()
}

// 더 안정적인 초기화를 위한 함수
function waitForJQueryAndRaty() {
  console.log('[Raty Debug] waitForJQueryAndRaty called');
  
  if (typeof window.$ !== 'undefined' && typeof window.$.fn.raty !== 'undefined') {
    console.log('[Raty Debug] Dependencies ready, calling initializeAllRaty');
    initializeAllRaty()
  } else {
    console.log('[Raty Debug] Dependencies not ready, retrying in 100ms');
    setTimeout(waitForJQueryAndRaty, 100)
  }
}

// Initialize on page load
document.addEventListener('turbo:load', function() {
  console.log('[Raty Debug] turbo:load event fired');
  waitForJQueryAndRaty();
});

document.addEventListener('DOMContentLoaded', function() {
  console.log('[Raty Debug] DOMContentLoaded event fired');
  waitForJQueryAndRaty();
});

// 추가적인 초기화 시도
document.addEventListener('turbo:render', function() {
  console.log('[Raty Debug] turbo:render event fired');
  setTimeout(function() {
    console.log('[Raty Debug] Calling ensureRatyInitialized after turbo:render');
    window.ensureRatyInitialized();
  }, 100);
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