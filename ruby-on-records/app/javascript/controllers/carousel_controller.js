import { Controller } from "@hotwired/stimulus"

// Gallery controller supporting Main Image + Thumbnails interaction
export default class extends Controller {
    static targets = ["mainImage", "slide"]

    connect() {
        // Pre-seleccionar la primera miniatura si existe
        if (this.hasSlideTarget) {
            this.highlightThumbnail(this.slideTargets[0])
        }
    }

    select(event) {
        // Obtenemos el elemento clickeado (la miniatura)
        const selectedThumb = event.currentTarget
        const imageUrl = selectedThumb.dataset.url

        // Actualizamos la imagen principal con una transición suave
        this.mainImageTarget.style.opacity = "0.5"
        
        setTimeout(() => {
            this.mainImageTarget.src = imageUrl
            this.mainImageTarget.style.opacity = "1"
        }, 150)

        // Actualizamos el estado visual de las miniaturas
        this.slideTargets.forEach(slide => {
            slide.classList.remove("ring-4", "ring-mustard")
            slide.classList.add("opacity-70", "hover:opacity-100")
        })

        this.highlightThumbnail(selectedThumb)
    }

    highlightThumbnail(thumbnail) {
        thumbnail.classList.remove("opacity-70", "hover:opacity-100")
        thumbnail.classList.add("ring-4", "ring-mustard", "opacity-100")
    }
}
