import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userTab", "allTab", "userContent", "allContent"]

  connect() {
    this.userTabTarget.addEventListener("click", () => this.showUserCommunities())
    this.allTabTarget.addEventListener("click", () => this.showAllCommunities())
  }

  showUserCommunities() {
    this.userTabTarget.classList.add("active")
    this.allTabTarget.classList.remove("active")
    this.userContentTarget.style.display = "block"
    this.allContentTarget.style.display = "none"
  }

  showAllCommunities() {
    this.allTabTarget.classList.add("active")
    this.userTabTarget.classList.remove("active")
    this.allContentTarget.style.display = "block"
    this.userContentTarget.style.display = "none"
  }
}
