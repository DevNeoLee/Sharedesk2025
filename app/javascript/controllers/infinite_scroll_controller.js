import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets =[ "entries", "pagination"]

    scroll() {
        // Check if pagination target exists
        if (!this.hasPaginationTarget) { return }
        
        let next_page = this.paginationTarget.querySelector("a[rel='next']")
        if (next_page == null) { return }

        let url = next_page.href 
  
        var body = document.body,
            html = document.documentElement

        var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

            if (window.pageYOffset >= height - window.innerHeight - 300 ) {
                this.loadMore(url)
            }
    }

    loadMore(url) {
        $.ajax({
            method: 'GET',
            url: url, 
            dataType: 'json',
            success: (data) => {
                // Store the current number of star elements before adding new content
                const existingStarElements = this.entriesTarget.querySelectorAll('.star-rating').length;
                
                // Find the row container
                const rowContainer = this.entriesTarget.querySelector('.row');
                if (!rowContainer) {
                    console.error('Row container not found');
                    return;
                }
                
                // 중복 room-card append 방지 로직
                const existingIds = new Set([...this.entriesTarget.querySelectorAll('.col-md-4')].map(col => {
                    const card = col.querySelector('.card');
                    return card ? card.dataset.roomId : null;
                }).filter(id => id !== null));
                
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = data.entries;
                const newCols = tempDiv.querySelectorAll('.col-md-4');
                
                newCols.forEach(col => {
                    const card = col.querySelector('.card');
                    if (card && card.dataset.roomId && !existingIds.has(card.dataset.roomId)) {
                        rowContainer.appendChild(col);
                    }
                });
                
                this.paginationTarget.innerHTML = data.pagination;
                // Initialize star ratings for newly loaded content only
                this.initializeNewStarRatings(existingStarElements)
            },
            error: (message) => {
                console.error('Error loading more content:', message);
            }
        })
    }
    
    initializeNewStarRatings(existingCount) {
        // Find all star rating elements and only process the new ones
        const allStarElements = this.entriesTarget.querySelectorAll('.star-rating');
        const newStarElements = Array.from(allStarElements).slice(existingCount);
        
        newStarElements.forEach(function(element, index) {
            const score = parseFloat(element.dataset.score) || 0;
            
            // Round to nearest 0.5
            const roundedScore = Math.round(score * 2) / 2;
            element.setAttribute('data-score', roundedScore);
            
            console.log(`[Infinite Scroll] New star rating ${index + 1} initialized with score: ${roundedScore}`);
        });
        
        console.log(`[Infinite Scroll] Initialized ${newStarElements.length} new star ratings`);
    }
}

