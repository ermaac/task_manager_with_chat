$(document).ready(function() {
  $(document).on('click', '.edit_note_button', function(){
    modal_window = $('.modal.bs-example-modal-sm').filter(function(){
      return $(this).css('display') == 'block';
    })
    $(modal_window).modal('toggle')
  })
})
