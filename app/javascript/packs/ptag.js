if (location.pathname.match("/new")||location.pathname.match("/edit")||location.pathname.match("practices")){
  document.addEventListener("DOMContentLoaded", () => {
    console.log("ok");
    const inputElement = document.getElementById("practices_ptag_name");
    inputElement.addEventListener("keyup", () => {
      let keyword = document.getElementById("practices_ptag_name").value;
      if(keyword.includes(',')){
        keyword=keyword.substring(keyword.lastIndexOf(',')+1,keyword.length-1);
        console.log(keyword);
      }

      const XHR = new XMLHttpRequest();
      XHR.open("GET", `ptaglist/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload=()=>{
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((ptag) => {
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
              console.log(clickElement.innerText);
              console.log(`tagForm=${tagForm.value+clickElement.innerText}`);
             
            });
          });
        };
      };
    });
  });
};
