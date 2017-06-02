
$(document).ready(function(){




//   $('li.tab').on('click', 'a', function(){
//
//     if ($(this).hasClass('active')){
//       return
//     }
//
//     var new_action = $(this).attr('change-to')
//
//     $('#user-modal form').attr('action', new_action)
//     $('.form-toggle').toggle()
//     if ($('form').attr('action') == '/sessions'){
//       $('#user-form-submit-button').text('Sign in')
//     } else {
//       $('#user-form-submit-button').text('Submit')
//     }
//     $('#user-modal-div input[type="checkbox"]').attr('checked', false)
//     $('#professional-info-div').hide();
//
//
//   })
//
//   $('#user-modal-div').on('click', '#user-form-submit-button', function(e){
//     e.preventDefault();
//     getLocation();
//
//
//   })
//
//   $('#user-modal-div').on('submit', 'form', function(e){
//     // console.log($(this))
//     e.preventDefault();
//     // console.log("form submit event")
//     // console.log("posting to ", $(this).attr('action'))
//     // console.log("data: ", $(this).serialize())
//     $.post({
//       url:$(this).attr('action'),
//       data:$(this).serialize(),
//       success: function(res){
//         console.log(res)
//
//         if (res.result == 'failure'){
//           var data = {"loc":'login'}
//           if (res.loc == 'register'){
//             data["loc"] = 'register'
//             console.log($('#special-user-checkbox'))
//             if ($('#special-user-checkbox').is(':checked')){
//               console.log("box is checked")
//               data["professional_info"] = true
//             } else {
//               console.log("box is not checked")
//             }
//           }
//           console.log(data)
//           $.get({
//             url:'/users/get_user_modal',
//             data: data,
//             success:function(res){
//               // console.log(res)
//               $('#user-modal-div').html(res)
//             }
//           })
//         } else{
//           location.reload()
//         }
//
//       }
//     })
//
//   })
//
//   $('#user-modal-div input[type="checkbox"]').on('click', function(){
//     $('#professional-info-div').toggle();
//   })
//
//   // $('#user-modal input').blur(function(){
//   //
//   //
//   //
//   //
//   // })
//
//
//
})
//
// function getLocation() {
//     if (navigator.geolocation) {
//         navigator.geolocation.getCurrentPosition(insertPos);
//     } else {
//         console.log("Geolocation is not supported by this browser.");
//     }
// }
//
// function insertPos(position) {
//     $('input[name="login[latitude]"]').val(position.coords.latitude);
//     $('input[name="login[longitude]"]').val(position.coords.longitude).done($('#user-modal-div form').trigger('submit'))
// }
