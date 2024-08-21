import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-set-count"
export default class extends Controller {
  static targets = ["input", "total"]

  connect() {
    console.log('connected')
  }

  calculateTotal() {
    const total = 0;
    this.inputTargets.forEach((input) => {
      total += parseFloat(input.value) || 0;
    });
    this.totalTarget.textContent = '=' + total;
  }
}
