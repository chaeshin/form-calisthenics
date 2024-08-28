import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    console.log("Collapse controller connected!");
  }

  toggle(e) {
    const btn = e.currentTarget;
    const content = btn.lastElementChild;
    console.log(this.contentTargets)
    this.contentTargets.forEach(element => {
      element.classList.remove("open");
    });
    content.classList.toggle("open");

    this.contentTargets.forEach(el => {
    if (el.classList.contains("open")) {
      el.style.maxHeight = el.scrollHeight + 'px';
    } else {
      el.style.maxHeight = null;
    }
    })
  }
}
