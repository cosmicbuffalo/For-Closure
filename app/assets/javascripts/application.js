// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function(){

  $('#hub-link').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrainWidth: false, // Does not change width of dropdown to that of the activator
      hover: true, // Activate on hover
      gutter: 0, // Spacing from edge
      belowOrigin: true, // Displays dropdown below the button
      alignment: 'right', // Displays dropdown with edge aligned to the left of button
      stopPropagation: false // Stops event propagation
    }
  );

  $('#user-modal').modal({opacity: .8});
  bindUserModalHandlers()

  $('.user-modal-link').on('click', function(e){

    e.preventDefault();

    if ($(this).attr('href') == '/users/new'){
      var data = {'loc':'register'}
      $.get({
        url:'/users/get_user_modal',
        data: data,
        success:function(res){
          // console.log(res)
          $('#user-modal').html(res).delay(320)
          // bindUserModalHandlers()
          $('ul.tabs').tabs();
          $('#user-modal').modal('open')
          window.dispatchEvent(new Event('resize'));
          $('div.modal-overlay').css('background','#fff')

        }
      })
    } else{
      $('#user-modal').modal('open')
      window.dispatchEvent(new Event('resize'));
      $('div.modal-overlay').css('background','#fff')
    }



  })






  // $('#user-modal input').blur(function(){
  //
  //
  //
  //
  // })



  })

  function bindUserModalHandlers(){

    // $('.tab').tabs();

    $('#user-modal').on('click', 'li.tab a', function(e){
      e.preventDefault();

      if ($(this).hasClass('active')){
        return
      }

      var new_action = $(this).attr('change-to')

      $('#user-modal form').attr('action', new_action)
      $('.form-toggle').toggle()
      if ($('form').attr('action') == '/sessions'){
        $('#user-form-submit-button').text('Sign in')
      } else {
        $('#user-form-submit-button').text('Submit')
      }
      $('#user-modal input[type="checkbox"]').attr('checked', false)
      $('#professional-info-div').hide();


    })

    $('#user-modal').one('click', '#user-form-submit-button', function(e){
      console.log("clicked form submit button")
      e.preventDefault();
      e.stopPropagation();

      if ($('#location-check').attr('have-location') == 'false'){
        console.log("couldn't find location, getting location before submitting form")
        getLocation();
      } else{
        console.log("location is already present, directly submitting form")
        $('#user-modal form').trigger('submit')
      }


    })

    $('#user-modal').on('submit', 'form', function(e){
      // console.log($(this))
      e.preventDefault();
      console.log("form submit event")
      console.log("posting to ", $(this).attr('action'))
      // console.log("data: ", $(this).serialize())
      $.post({
        url:$(this).attr('action'),
        data:$(this).serialize(),
        success: function(res){
          console.log("initial post result", res)

          if (res.result == 'failure'){

            var data = {"loc":'login'}
            if (res.loc == 'register'){
              data["loc"] = 'register'
              // console.log($('#special-user-checkbox'))
              if ($('#special-user-checkbox').is(':checked')){
                // console.log("box is checked")
                data["professional_info"] = true
              } else {
                // console.log("box is not checked")
              }
            }
            console.log("Data for get of new modal content", data)
            $.get({
              url:'/users/get_user_modal',
              data: data,
              success:function(res){
                // console.log(res)
                $('#user-modal').html(res)
                console.log("replaced modal content")
              }
            })
          } else{
            console.log("post was successful, refreshing page")
            location.reload()

          }

        }
      })

    })

    $('#user-modal').on('click','input[type="checkbox"]', function(){
      $('#professional-info-div').toggle();
    })


  }

  function getLocation() {

    console.log("getting location")

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(insertPos);
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
  }

  function insertPos(position) {
    $('input[name="login[latitude]"]').val(position.coords.latitude);
    $('input[name="login[longitude]"]').val(position.coords.longitude).done(function(){
      console.log("about to trigger submit on form after grabbing position")
      $('#user-modal form').trigger('submit')
    }())
  }
