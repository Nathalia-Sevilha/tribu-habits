import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.colorInput = this.element.querySelector('input[name="habit[color]"]')
    this.colorChoices = this.element.querySelectorAll('.color-choice')
    
    this.colorChoices.forEach(choice => {
      choice.addEventListener('click', () => {
        // Remove selected class from all choices
        this.colorChoices.forEach(c => c.classList.remove('selected'))
        // Add selected class to clicked choice
        choice.classList.add('selected')
        // Update hidden input value
        this.colorInput.value = choice.dataset.color
      })
    })
  }
}