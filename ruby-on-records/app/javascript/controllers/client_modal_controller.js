import { Controller } from "@hotwired/stimulus"

// Controlador Stimulus para modal de creación rápida de clientes
export default class extends Controller {
    static targets = ["modal", "form", "nameInput", "dniInput", "emailInput", "phoneInput", "errors", "submitButton"]
    static values = {
        url: String
    }

    connect() {
        // Cerrar modal con ESC
        this.boundHandleKeydown = this.handleKeydown.bind(this)
    }

    disconnect() {
        document.removeEventListener('keydown', this.boundHandleKeydown)
    }

    open(event) {
        event?.preventDefault()
        this.modalTarget.classList.remove('hidden')
        this.modalTarget.classList.add('flex')
        document.body.style.overflow = 'hidden'
        document.addEventListener('keydown', this.boundHandleKeydown)

        // Focus en el primer campo
        setTimeout(() => this.nameInputTarget.focus(), 100)
    }

    close(event) {
        event?.preventDefault()
        this.modalTarget.classList.add('hidden')
        this.modalTarget.classList.remove('flex')
        document.body.style.overflow = ''
        document.removeEventListener('keydown', this.boundHandleKeydown)
        this.resetForm()
    }

    // Cerrar al hacer click en el backdrop
    closeOnBackdrop(event) {
        if (event.target === this.modalTarget) {
            this.close()
        }
    }

    handleKeydown(event) {
        if (event.key === 'Escape') {
            this.close()
        }
    }

    async submit(event) {
        event.preventDefault()

        this.clearErrors()
        this.setLoading(true)

        const formData = new FormData()
        formData.append('client[name]', this.nameInputTarget.value)
        formData.append('client[dni]', this.dniInputTarget.value)
        formData.append('client[email]', this.emailInputTarget.value)
        formData.append('client[phone]', this.phoneInputTarget.value)

        try {
            const response = await fetch(this.urlValue, {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'X-CSRF-Token': this.csrfToken
                },
                body: formData
            })

            const data = await response.json()

            if (response.ok && data.success) {
                this.handleSuccess(data)
            } else {
                this.handleErrors(data.errors || ['Error al crear el cliente'])
            }
        } catch (error) {
            console.error('Error creando cliente:', error)
            this.handleErrors(['Error de conexión. Por favor intente nuevamente.'])
        } finally {
            this.setLoading(false)
        }
    }

    handleSuccess(data) {
        // Disparar evento personalizado para que el autocomplete lo capture
        const event = new CustomEvent('client-created', {
            detail: { client: data.client },
            bubbles: true
        })
        this.element.dispatchEvent(event)

        // Mostrar mensaje de éxito
        this.showSuccessMessage(data.message)

        // Cerrar modal después de un breve delay
        setTimeout(() => this.close(), 800)
    }

    handleErrors(errors) {
        this.errorsTarget.innerHTML = `
      <div class="bg-rust/20 border-l-4 border-rust p-4 mb-4">
        <div class="flex">
          <div class="flex-shrink-0">
            <svg class="h-5 w-5 text-rust" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
            </svg>
          </div>
          <div class="ml-3">
            <h3 class="text-sm font-bold text-rust">Error al crear cliente</h3>
            <div class="mt-2 text-sm text-vinyl-dark">
              <ul class="list-disc pl-5 space-y-1">
                ${errors.map(error => `<li>${this.escapeHtml(error)}</li>`).join('')}
              </ul>
            </div>
          </div>
        </div>
      </div>
    `
        this.errorsTarget.classList.remove('hidden')
    }

    showSuccessMessage(message) {
        this.errorsTarget.innerHTML = `
      <div class="bg-green-100 border-l-4 border-green-500 p-4 mb-4">
        <div class="flex">
          <div class="flex-shrink-0">
            <svg class="h-5 w-5 text-green-500" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
            </svg>
          </div>
          <div class="ml-3">
            <p class="text-sm font-bold text-green-700">${this.escapeHtml(message)}</p>
          </div>
        </div>
      </div>
    `
        this.errorsTarget.classList.remove('hidden')
    }

    clearErrors() {
        this.errorsTarget.innerHTML = ''
        this.errorsTarget.classList.add('hidden')
    }

    setLoading(loading) {
        if (loading) {
            this.submitButtonTarget.disabled = true
            this.submitButtonTarget.innerHTML = `
        <svg class="animate-spin h-5 w-5 mr-2 inline-block" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
        </svg>
        Creando...
      `
        } else {
            this.submitButtonTarget.disabled = false
            this.submitButtonTarget.textContent = 'Crear Cliente'
        }
    }

    resetForm() {
        this.formTarget.reset()
        this.clearErrors()
    }

    get csrfToken() {
        return document.querySelector('meta[name="csrf-token"]')?.content || ''
    }

    escapeHtml(text) {
        const div = document.createElement('div')
        div.textContent = text
        return div.innerHTML
    }
}
