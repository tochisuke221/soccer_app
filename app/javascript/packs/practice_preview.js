
    const ImageList = document.getElementById('practice-views');
    const submit=document.getElementById("submit");
    document.getElementById('practice_image').addEventListener('change', (e)=>{
      while(ImageList.lastChild){
        ImageList.removeChild(ImageList.lastChild);
      }
     });
    document.getElementById('practice_image').addEventListener('change', (e)=>{
      const files = e.target.files;
      if(files.length>4){
        alert("投稿できる画像数は4枚までです");
        submit.setAttribute("disabled",true);
        return false;
      }else{
        if(submit.disabled){
          submit.removeAttribute("disabled",true);
        }
      }
      Array.from(files).forEach(file => {
        const blob = window.URL.createObjectURL(file);
        const imageElement = document.createElement('div');
        imageElement.setAttribute('class','preview_image' );  
  
         // 表示する画像を生成
         const blobImage = document.createElement('img');
         blobImage.setAttribute('src', blob);
         imageElement.appendChild(blobImage);
         ImageList.appendChild(imageElement);
      });
    });
  
  


