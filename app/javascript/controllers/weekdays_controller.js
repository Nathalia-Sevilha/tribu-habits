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
  changeDay(event) {
    const dayName = event.currentTarget.dataset.dayName;
    Turbo.visit(`/habits?day=${dayName}`, { frame: "progress-card" });
    Turbo.visit(`/habits?day=${dayName}`, { frame: "habits-list" });
  }
}
