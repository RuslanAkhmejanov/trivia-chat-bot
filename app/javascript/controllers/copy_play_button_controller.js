import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const playButton = this.element;
    const playButtonClon = playButton.cloneNode(true);
    window.playButtonClon = playButtonClon;
  }
}
