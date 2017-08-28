window.setTimeout(function() {
  $(".alert").fadeTo(4500, 0).slideUp(500, function(){
    $(this).remove();
  });
}, 2000);
