$(document).ready(function () {
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('#modal1').modal();
  $('.materialboxed').materialbox();

});




var map;
function initMap() {

  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: { lat: Number($('#hiddenDiv').attr("latitude")), lng: Number($('#hiddenDiv').attr("longitude")) }
    //  
  });
  
  renderQueryset(map)
  

}


 Number($('#hiddenDiv').attr("longitude"))

function renderQueryset(map) {
  $.get({
    url: 'listings/query',
    dataType: 'json',
    success: function (res) {
     console.log(res)
      propertyQuery(map, res)
    }
  })
}


// Multipurpose function!
function propertyQuery(map, res) {
  var bounds = new google.maps.LatLngBounds();
  for (var i = 0; i < res.length; i++) {

    var myLatLng = new google.maps.LatLng(res[i].latitude, res[i].longitude);

    
    if (res[i].rent == false){
      var priceString = "$"+res[i].price
    }
    else{
      var priceString = "$" + res[i].price + "/mo"
    }
    var marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      icon: new google.maps.MarkerImage($('#hiddenDiv').attr("marker"),
      null, /* size is determined at runtime */
      null, /* origin is 0,0 */
      null, /* anchor is bottom center of the scaled image */
      new google.maps.Size(25, 25)
    ),
      propId: res[i].id

    })
  try{
    var content = '<img  src="'+ res[i].images[0].image.url+ '"alt= "Nothin" height="45">';
  }

  catch (err) {
    var content = '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png" alt= "Nothin" height="45">'
  }

  content += '<div class="hover-info"><ul> <li>' + priceString +"</li><br>" + "<li>"+res[i].bedroom +"bd | " + res[i].bathroom + "br</li><br>" +"<li>" + res[i].square_feet +" sqft </li>" + "</div>";
    var infowindow = new google.maps.InfoWindow()

    google.maps.event.addListener(marker, 'mouseover', (function (marker, content, infowindow) {
      return function () {
        infowindow.setContent(content);
        infowindow.open(map, marker);
      };
    })(marker, content, infowindow));
    google.maps.event.addListener(marker, 'mouseout', (function (marker, content, infowindow) {
      return function () {
        infowindow.close();
      };
    })(marker, content, infowindow));

    google.maps.event.addListener(marker,'click', function(position){
        console.log(this.propId)
        $.get({
          url: 'listings/info',
          data: {"id": this.propId},
          success: function (res){
            $('#modal1').html(res)
            $('.materialboxed').materialbox();
            // Spilting up the replaces to better organize
            // var addressBanner = '<h4 id="address-banner">' + res.address+ "</h4>"
            // $('#address-banner').replaceWith(addressBanner)

            // var addressDetails = '<p id="address-details"><b>' + res.bedroom + "bd | "+res.bathroom+"br | " + res.square_feet + "sqft </b></p>"
            // $('#address-details').replaceWith(addressDetails)

            // var addressDescription = '<p id="address-description">' + res.description + '</p>'
            // $('#address-description').replaceWith(addressDescription)

            // if (res.rent == false){
            //   var addressListType = '<p id="address-list-type">For Sale</p>'
            //   var addressPrice = '<h4 id="address-price"><b> $' + res.price + '</b></h4>'
            // }
            // else{
            //   var addressListType = '<p id="address-list-type">For Rent</p>'
            //   var addressPrice = '<h4 id="address-price"><b> $' + res.price + ' /mo</b></h4>'
            // }
            // $('#address-list-type').replaceWith(addressListType)
            // $('#address-price').replaceWith(addressPrice)

           


          }
        })
        $('#modal1').modal('open');
      });

  }
}
