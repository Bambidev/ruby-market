import { Controller } from "@hotwired/stimulus"

// Controlador Stimulus para autocompletado de clientes
// Conecta con el endpoint /admin/clients/search
export default class extends Controller {
    static targets = ["input", "results", "hiddenField"]
    static values = {
        url: String,
        minChars: { type: Number, default: 2 }
    }

    connect() {
        this.timeout = null
        this.selectedIndex = -1
    }

    disconnect() {
        this.clearTimeout()
    }

    // Buscar clientes mientras el usuario escribe
    search() {
        this.clearTimeout()

        const query = this.inputTarget.value.trim()

        if (query.length < this.minCharsValue) {
            this.hideResults()
            return
        }

        // Debounce: esperar 300ms antes de buscar
        this.timeout = setTimeout(() => {
            this.performSearch(query)
        }, 300)
    }

    async performSearch(query) {
        try {
            const url = `${this.urlValue}?q=${encodeURIComponent(query)}`
            const response = await fetch(url, {
                headers: {
                    "Accept": "application/json"
                }
            })

            if (!response.ok) throw new Error("Error en la búsqueda")

            const clients = await response.json()
            this.displayResults(clients)
        } catch (error) {
            console.error("Error buscando clientes:", error)
            this.hideResults()
        }
    }

    displayResults(clients) {
        if (clients.length === 0) {
            this.resultsTarget.innerHTML = `
        <div class="p-4 text-sm text-vinyl-dark/60 text-center">
          No se encontraron clientes. 
          <button type="button" 
                  data-action="click->client-modal#open" 
                  class="text-mustard hover:text-mustard-dark font-bold underline">
            Crear nuevo
          </button>
        </div>
      `
            this.showResults()
            return
        }

        this.resultsTarget.innerHTML = clients.map((client, index) => `
      <button type="button"
              class="w-full text-left px-4 py-3 hover:bg-mustard/10 transition-colors border-b border-vinyl-black/10 focus:bg-mustard/20 focus:outline-none"
              data-action="click->client-autocomplete#select"
              data-client-id="${client.id}"
              data-client-name="${this.escapeHtml(client.name)}"
              data-index="${index}">
        <div class="font-bold text-vinyl-black">${this.highlightMatch(client.name, this.inputTarget.value)}</div>
        <div class="text-xs text-vinyl-dark/60">
          DNI: ${client.dni}
          ${client.email ? `| Email: ${client.email}` : ''}
          ${client.phone ? `| Tel: ${client.phone}` : ''}
        </div>
      </button>
    `).join('')

        this.showResults()
    }

    select(event) {
        const button = event.currentTarget
        const clientId = button.dataset.clientId
        const clientName = button.dataset.clientName

        // Actualizar campo oculto con el ID
        this.hiddenFieldTarget.value = clientId

        // Actualizar input visible con el nombre
        this.inputTarget.value = clientName

        // Ocultar resultados
        this.hideResults()

        // Marcar como seleccionado visualmente
        this.inputTarget.classList.add('border-green-500', 'bg-green-50')
    }

    // Limpiar selección cuando el usuario empieza a escribir de nuevo
    clearSelection() {
        this.hiddenFieldTarget.value = ''
        this.inputTarget.classList.remove('border-green-500', 'bg-green-50')
    }

    // Manejar evento cuando se crea un cliente desde el modal
    handleClientCreated(event) {
        const client = event.detail.client

        // Actualizar campo oculto con el ID del nuevo cliente
        this.hiddenFieldTarget.value = client.id

        // Actualizar input visible con el nombre
        this.inputTarget.value = client.name

        // Marcar como seleccionado
        this.inputTarget.classList.add('border-green-500', 'bg-green-50')

        // Ocultar resultados si estaban abiertos
        this.hideResults()
    }

    showResults() {
        this.resultsTarget.classList.remove('hidden')
    }

    hideResults() {
        this.resultsTarget.classList.add('hidden')
        this.selectedIndex = -1
    }

    // Cerrar resultados al hacer click fuera
    clickOutside(event) {
        if (!this.element.contains(event.target)) {
            this.hideResults()
        }
    }

    // Navegación con teclado
    navigate(event) {
        const items = this.resultsTarget.querySelectorAll('button')

        if (items.length === 0) return

        switch (event.key) {
            case 'ArrowDown':
                event.preventDefault()
                this.selectedIndex = Math.min(this.selectedIndex + 1, items.length - 1)
                this.highlightItem(items)
                break
            case 'ArrowUp':
                event.preventDefault()
                this.selectedIndex = Math.max(this.selectedIndex - 1, 0)
                this.highlightItem(items)
                break
            case 'Enter':
                event.preventDefault()
                if (this.selectedIndex >= 0) {
                    items[this.selectedIndex].click()
                }
                break
            case 'Escape':
                this.hideResults()
                break
        }
    }

    highlightItem(items) {
        items.forEach((item, index) => {
            if (index === this.selectedIndex) {
                item.classList.add('bg-mustard/20')
                item.scrollIntoView({ block: 'nearest' })
            } else {
                item.classList.remove('bg-mustard/20')
            }
        })
    }

    // Helpers
    clearTimeout() {
        if (this.timeout) {
            clearTimeout(this.timeout)
            this.timeout = null
        }
    }

    highlightMatch(text, query) {
        if (!query) return this.escapeHtml(text)

        const regex = new RegExp(`(${this.escapeRegex(query)})`, 'gi')
        return this.escapeHtml(text).replace(regex, '<mark class="bg-mustard/30 font-bold">$1</mark>')
    }

    escapeHtml(text) {
        const div = document.createElement('div')
        div.textContent = text
        return div.innerHTML
    }

    escapeRegex(text) {
        return text.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
    }
}
