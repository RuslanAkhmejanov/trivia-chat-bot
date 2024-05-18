import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  handleClick(event) {
    const chatButtonsFrame = document.getElementById("chat-buttons");
    chatButtonsFrame.remove();

    const chatMessagesFrame = document.getElementById("chat-messages");
    chatMessagesFrame.remove();

    const chatCard = document.getElementById("chat-card");
    chatCard.appendChild(window.playButtonClon);
  }
}
