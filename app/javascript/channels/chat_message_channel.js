import consumer from "./consumer"

consumer.subscriptions.create("ChatMessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<p>${data.content.content}</p>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('chat_message_content');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
  }
});
