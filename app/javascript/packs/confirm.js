const confirm = () =>{
  const btn=document.getElementById("goodbye-btn");
  btn.addEventListener("click",()=>{
    window.confirm("本当に退会しますか？退会後は全てのデータが削除されます");
  });
}



window.addEventListener("load",confirm)  
