// メニュー操作

// トグルリスナーを追加してクリックをリッスンする
//ページを開いた時
document.addEventListener("turbo:load", function() {
  //for mobile menu
  let hamburger = document.querySelector("#hamburger");
  if (hamburger){
    hamburger.addEventListener("click", function(event) {
      event.preventDefault();
      let menu = document.querySelector("#navbar-menu");
      menu.classList.toggle("collapse");
    });
  }

  let account = document.querySelector("#account");
  if (account) {
    account.addEventListener("click", function(event) {
      event.preventDefault();
      let menu = document.querySelector("#dropdown-menu");
      menu.classList.toggle("active");
    });
  }
});
