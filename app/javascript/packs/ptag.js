if (location.pathname.match("/new")||location.pathname.match("/edit")||location.pathname.match("/practices")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("practices_ptag_name");
    inputElement.addEventListener("keyup", () => {
      let keyword = document.getElementById("practices_ptag_name").value;
      if(keyword.includes(',')){
        keyword=keyword.substring(keyword.lastIndexOf(',')+1,keyword.length);
      }

      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/practices/ptaglist/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();

      XHR.onload=()=>{
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((ptag) => {
            //2語目以降、重複キーワードは表示しない
            if(keyword.includes(',')){
              let flag=false;
              words=inputElement.value.split(",");
              words.forEach((word)=>{
                if(ptag.name==word){
                    flag=true;
                    return true;
                }
              });
              if(flag==true){return true};
            }
            ////////////
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", ptag.id);
            childElement.innerHTML = ptag.name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(ptag.id);
            
            clickElement.addEventListener("click", () => {
              let tagForm= document.getElementById("practices_ptag_name") ;
              tagForm.value=tagForm.value.substring(tagForm.value.lastIndexOf(",")+1,tagForm.value.lastIndexOf(",")-tagForm.length);
              tagForm.value=tagForm.value.concat(clickElement.innerText);
              
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};
