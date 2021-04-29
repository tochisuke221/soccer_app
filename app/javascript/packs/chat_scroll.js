console.log("Ok");
const scroll = () =>{
  $('#chat-messages').scrollTop($('#chat-messages')[0].scrollHeight);
}



window.addEventListener("load",scroll)  
