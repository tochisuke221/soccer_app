

  const count = () =>{
    const form=document.getElementById("lesson-content");
    form.addEventListener("keyup",()=>{
      const count_num=form.value.length
      const span=document.getElementById("char-count");
      span.innerHTML=count_num
    });
  }
  
  
  
  window.addEventListener("load",count)  


