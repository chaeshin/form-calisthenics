import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-set-count"
export default class extends Controller {
  static targets = ["input", "total"]

  connect() {
    console.log('connected')
  }

  calculateTotal() {
    this.total = 0;
    this.inputTargets.forEach((input) => {
      this.total += parseFloat(input.value) || 0;
    });
    console.log(this.totalTarget)
    this.totalTarget.innerText = '=' + this.total;
  }
}
