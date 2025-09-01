// app/javascript/controllers/weekdays_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    this.buttonTargets.forEach(btn => {
      btn.addEventListener("click", () => this.select(btn))
    })
  }

  select(selectedButton) {
    this.buttonTargets.forEach(btn => btn.classList.remove("active"))
    selectedButton.classList.add("active")
  }
}
