$( document ).ready(function() {
  if(!($('#first_name')).val()) {
    $('#first_name').css( "border", "2px solid red" );
  };

  if(!($('#last_name')).val()) {
    $('#last_name').css( "border", "2px solid red" );
  };
});


