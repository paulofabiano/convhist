import { Controller } from "@hotwired/stimulus"
import { patch } from "@rails/request.js"

export default class extends Controller {
  static values = {
    project: String
  }

  change(event) {
    let status = event.target.selectedOptions[0].value

    patch(`/projects/${this.projectValue}`, {
      body: JSON.stringify({ status: status }),
      responseKind: "turbo-stream"
    })
  }
}