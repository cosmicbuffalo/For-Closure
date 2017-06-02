
$(document).on('turbolinks:load', function(){


  $('#search-selector').on('click', 'button', function(){
    $('button').removeClass('selected')
    $(this).addClass('selected')
    $('#search-option').val($(this).attr('name'))
    $('#main-centered-section').removeClass('buy rent sell zestimate')
    $('#main-centered-section').addClass($(this).attr('name'))
    $('#main-title').html($(this).attr('title'))
  })

})
