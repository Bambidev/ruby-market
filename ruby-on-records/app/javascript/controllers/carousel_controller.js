import { Controller } from "@hotwired/stimulus"

// Simple carousel controller - no external dependencies
export default class extends Controller {
    static targets = ["slide"]

    connect() {
        this.currentIndex = 0
        this.totalSlides = this.slideTargets.length
        this.updateSlides()
    }

    next() {
        this.currentIndex = (this.currentIndex + 1) % this.totalSlides
        this.updateSlides()
    }

    prev() {
        this.currentIndex = (this.currentIndex - 1 + this.totalSlides) % this.totalSlides
        this.updateSlides()
    }

    updateSlides() {
        this.slideTargets.forEach((slide, index) => {
            if (index === this.currentIndex) {
                slide.style.display = "block"
            } else {
                slide.style.display = "none"
            }
        })
    }
}
