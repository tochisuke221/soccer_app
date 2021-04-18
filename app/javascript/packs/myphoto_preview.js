document.addEventListener('DOMContentLoaded', function(){
  console.log("ok");
  const ImageList = document.getElementById('image-list');
  document.getElementById('user_myphoto').addEventListener('change', (e)=>{
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
     // 画像を表示するためのdiv要素を生成
     const imageElement = document.createElement('div');

     // 表示する画像を生成
     const blobImage = document.createElement('img');
     blobImage.setAttribute('src', blob);
     imageElement.appendChild(blobImage);
     console.log(imageElement);
     console.log(ImageList);
     ImageList.appendChild(imageElement);
     document.getElementById('user_myphoto').addEventListener('change', (e)=>{
      imageElement.remove();
     });
  });
});
