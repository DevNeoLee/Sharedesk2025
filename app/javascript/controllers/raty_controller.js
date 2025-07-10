import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rating"]
  static values = { score: Number }

  connect() {
    this.initializeRaty()
  }

  initializeRaty() {
    if (typeof window.$ !== 'undefined' && typeof window.jQuery !== 'undefined' && typeof window.$.fn.raty !== 'undefined') {
      this.ratingTargets.forEach(element => {
        if (!element.classList.contains('raty-initialized')) {
          const score = element.getAttribute('data-score') || 0
          const imagePath = this.getImagePath()
          
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
          } catch (error) {
            console.error('Error initializing Raty:', error)
          }
        }
      })
    } else {
      // Retry if jQuery or Raty not loaded yet
      setTimeout(() => this.initializeRaty(), 100)
    }
  }

  getImagePath() {
    return (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') 
      ? '/assets/' 
      : '/images/'
  }
} 