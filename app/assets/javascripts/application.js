//= require jquery
//= require jquery_ujs
//= require turbolinks

$(document).on('page:change', function() {
  // External Links
  $('a[rel~="external"]').on('click', function(event) {
    event.preventDefault();
    window.open(this.href);
  });
});
