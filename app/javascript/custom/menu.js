document.addEventListener("turbo:load", function() {
  // For mobile menu
  const hamburger = document.querySelector("#hamburger");
  if (hamburger) {
    hamburger.addEventListener("click", function(event) {
      event.preventDefault();
      const menu = document.querySelector("#navbar-menu");
      menu.classList.toggle("collapse");
    });
  }

  // For dropdown menu
  const account = document.querySelector("#account");
  if (account) {
    account.addEventListener("click", function(event) {
      event.preventDefault();
      const dropdownMenu = document.querySelector("#dropdown-menu");
      dropdownMenu.classList.toggle("active");
    });
  }
});
