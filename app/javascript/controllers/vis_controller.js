import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }

  visible(e) {
    const disablebtn = document.getElementById("disablebtn").removeAttribute("class")
  }
}
