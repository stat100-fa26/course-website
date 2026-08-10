document.addEventListener("DOMContentLoaded", function() {
  var togglers = document.querySelectorAll('.navbar-toggler[role="menu"]');
  togglers.forEach(function(toggler) {
    toggler.removeAttribute("role");
  });
});