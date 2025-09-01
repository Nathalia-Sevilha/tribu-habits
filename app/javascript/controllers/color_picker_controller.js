// app/javascript/controllers/color_picker_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "swatch"]

  connect() {
    // initialize preview on load
    this.update()
  }

  update() {
    // Expect values like "F09393" (no #)
    const raw = this.hasSelectTarget ? this.selectTarget.value : ""
    const hex = raw?.replace(/^#/, "")
    const color = hex ? `#${hex}` : "transparent"

    if (this.hasSwatchTarget) {
      this.swatchTarget.style.background = color
      this.swatchTarget.style.borderColor = hex ? color : "#ddd"
    }
  }
}

