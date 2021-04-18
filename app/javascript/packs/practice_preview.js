document.addEventListener('DOMContentLoaded', function(){
  console.log("ok");
  const ImageList = document.getElementById('practice-views');
  document.getElementById('practice_image').addEventListener('change', (e)=>{
    const files = e.target.files;
    console.log(files);
    Array.from(files).forEach(file => {
      const blob = window.URL.createObjectURL(file);
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class','preview_image' );  

       // 表示する画像を生成
       const blobImage = document.createElement('img');
       blobImage.setAttribute('src', blob);
       imageElement.appendChild(blobImage);
       console.log(imageElement);
       console.log(ImageList);
       ImageList.appendChild(imageElement);
    });
    document.getElementById('practice_image').addEventListener('change', (e)=>{
     imageElement.remove();
    });
  });
});
