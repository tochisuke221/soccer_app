import consumer from "./consumer"

consumer.subscriptions.create("ChatMessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let html;
     if (document.URL.match( `/users/${data.content.user_id}`)){
       html = `
       <div class="otheruser_message_box">
         <div class="other_message">
         ${data.content.content}
         </div>
       </div>
       `;
    } else{
      html = `
        <div class="my_message_box">
          <div class="my_message">
          ${data.content.content}
          </div>
        </div>
        `;
    }
  
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('chat_message_content');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
    
    // const chat=document.getElementById("chat-messages");
    // $('#chat-messages').scrollTop($('#chat-messages')[0].scrollHeight);
     const chat=document.getElementById("chat-messages");
     let height=chat.scrollHeight 
     chat.scrollTop=height;
    }
});
