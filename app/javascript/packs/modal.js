$(document).on('click', '.fa-times', function(){
  var path = $(this).attr('path');
  $(this).attr('href', path);
});
