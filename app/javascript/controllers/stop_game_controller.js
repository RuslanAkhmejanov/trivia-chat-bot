import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  handleClick(event) {
    const chatButtonsFrame = document.getElementById("chat-buttons");
    chatMessagesFrame.remove();

    const chatMessagesFrame = document.getElementById("chat-messages");
    chatMessagesFrame.remove();

    const targetDiv = document.getElementById("chat-card");
    targetDiv.appendChild(window.clonedElement);
  }
}
