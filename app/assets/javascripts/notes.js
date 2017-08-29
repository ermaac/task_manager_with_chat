$(document).ready(function() {
  $(document).on('click', '.edit_note_button', function(){
    console.log('A-a-a-a-a!')
    modal_window = $('.modal.bs-example-modal-sm').filter(function(){
      return $(this).css('display') == 'block';
    })
    console.log(modal_window.length)
    $(modal_window).modal('toggle')
  })
})
