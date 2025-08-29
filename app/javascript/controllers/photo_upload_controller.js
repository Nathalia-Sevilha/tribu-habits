import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"]

  change() {
    this.element.submit();
  }
}
