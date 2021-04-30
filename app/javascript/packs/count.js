

  const count = () =>{
    const form=document.getElementById("lesson-content");
    const span=document.getElementById("char-count");
    //何もしない状態（render後入力済み状態含む）での文字数
    const count_num=form.value.length
    span.innerHTML=count_num
    //キーボードを押した後での文字数
    form.addEventListener("keyup",()=>{
      const count_num=form.value.length
      span.innerHTML=count_num
    });
  }
  
  
  
  window.addEventListener("load",count)  


