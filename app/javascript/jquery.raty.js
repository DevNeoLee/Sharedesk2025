// jQuery Raty Plugin for star ratings
// This is a placeholder for the jQuery Raty plugin
// You may need to download the actual plugin or use a CDN version

(function($) {
  'use strict';
  
  // Basic star rating functionality
  $.fn.raty = function(options) {
    var defaults = {
      starType: 'i',
      starOn: 'fa fa-star',
      starOff: 'fa fa-star-o',
      starHalf: 'fa fa-star-half-o',
      score: 0,
      number: 5,
      half: true,
      space: true,
      hints: ['bad', 'poor', 'regular', 'good', 'gorgeous'],
      click: null,
      mouseover: null,
      mouseout: null
    };
    
    var settings = $.extend({}, defaults, options);
    
    return this.each(function() {
      var $this = $(this);
      var $stars = $('<div class="raty-stars"></div>');
      
      for (var i = 1; i <= settings.number; i++) {
        var $star = $('<i class="' + settings.starOff + '" data-score="' + i + '"></i>');
        $stars.append($star);
      }
      
      $this.html($stars);
      
      // Set initial score
      if (settings.score > 0) {
        setScore(settings.score);
      }
      
      // Click handler
      $stars.on('click', 'i', function() {
        var score = $(this).data('score');
        setScore(score);
        if (settings.click) {
          settings.click.call(this, score, $this);
        }
      });
      
      // Mouseover handler
      $stars.on('mouseenter', 'i', function() {
        var score = $(this).data('score');
        highlightStars(score);
        if (settings.mouseover) {
          settings.mouseover.call(this, score, $this);
        }
      });
      
      // Mouseout handler
      $stars.on('mouseleave', function() {
        highlightStars(settings.score);
        if (settings.mouseout) {
          settings.mouseout.call(this, settings.score, $this);
        }
      });
      
      function setScore(score) {
        settings.score = score;
        highlightStars(score);
      }
      
      function highlightStars(score) {
        $stars.find('i').each(function(index) {
          var $star = $(this);
          var starScore = index + 1;
          
          if (starScore <= score) {
            $star.removeClass(settings.starOff).addClass(settings.starOn);
          } else {
            $star.removeClass(settings.starOn).addClass(settings.starOff);
          }
        });
      }
    });
  };
})(jQuery); 