import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rating"]
  static values = { score: Number }

  connect() {
    console.log('[Raty Controller Debug] Controller connected');
    console.log('[Raty Controller Debug] Rating targets found:', this.ratingTargets.length);
    this.initializeRaty()
  }

  disconnect() {
    console.log('[Raty Controller Debug] Controller disconnecting');
    // 컨트롤러가 제거될 때 raty 인스턴스 정리
    this.ratingTargets.forEach((element, index) => {
      if (element.classList.contains('raty-initialized')) {
        console.log(`[Raty Controller Debug] Destroying raty instance ${index + 1}`);
        try {
          window.$(element).raty('destroy')
          element.classList.remove('raty-initialized')
          console.log(`[Raty Controller Debug] Successfully destroyed raty instance ${index + 1}`);
        } catch (error) {
          console.error(`[Raty Controller Debug] Error destroying Raty instance ${index + 1}:`, error)
        }
      }
    })
  }

  initializeRaty() {
    console.log('[Raty Controller Debug] initializeRaty called');
    
    if (typeof window.$ !== 'undefined' && typeof window.jQuery !== 'undefined' && typeof window.$.fn.raty !== 'undefined') {
      console.log('[Raty Controller Debug] Dependencies available in controller');
      
      this.ratingTargets.forEach((element, index) => {
        console.log(`[Raty Controller Debug] Processing target ${index + 1}:`, element);
        
        if (!element.classList.contains('raty-initialized')) {
          const score = element.getAttribute('data-score') || 0
          const imagePath = this.getImagePath()
          
          console.log(`[Raty Controller Debug] Initializing target ${index + 1}:`, {
            element: element,
            score: score,
            imagePath: imagePath,
            starOff: imagePath + 'star-off.png',
            starOn: imagePath + 'star-on.png',
            starHalf: imagePath + 'star-half.png'
          });
          
          try {
            window.$(element).raty({
              readOnly: true,
              score: score,
              starOff: imagePath + 'star-off.png',
              starOn: imagePath + 'star-on.png',
              starHalf: imagePath + 'star-half.png',
              size: 24,
              hints: ['1 star', '2 stars', '3 stars', '4 stars', '5 stars']
            })
            element.classList.add('raty-initialized')
            console.log(`[Raty Controller Debug] Successfully initialized target ${index + 1}`);
          } catch (error) {
            console.error(`[Raty Controller Debug] Error initializing Raty for target ${index + 1}:`, error)
          }
        } else {
          console.log(`[Raty Controller Debug] Target ${index + 1} already initialized, skipping`);
        }
      })
    } else {
      console.log('[Raty Controller Debug] Dependencies not available in controller:', {
        jquery: typeof window.$,
        raty: typeof window.$.fn?.raty
      });
      // Retry if jQuery or Raty not loaded yet
      setTimeout(() => this.initializeRaty(), 200)
    }
  }

  getImagePath() {
    const path = '/assets/';
    console.log('[Raty Controller Debug] Image path resolved to:', path);
    return path;
  }
} 