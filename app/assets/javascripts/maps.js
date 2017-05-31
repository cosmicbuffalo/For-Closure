$(document).ready(function () {
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('#modal1').modal();



});




var map;
function initMap() {

  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: { lat: 41.896862899999995, lng: -87.6344093 }
    // $('#hiddenDiv').attr("latitude") $('#hiddenDiv').attr("longitude")
  });
  
  renderQueryset(map)

}


function renderQueryset(map) {
  $.get({
    url: 'query',
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
    var address = res[i].address;

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
    var content = address;

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
        console.log(this.customInfo)
        $.post({
          url: 'info',
          data: {"id": this.propId},
          dataType: 'json',
          success: function (res){

            // Spilting up the replaces to better organize
            var addressBanner = '<h4 id="address-banner">' + res.address+ "</h4>"
            $('#address-banner').replaceWith(addressBanner)

            var addressDetails = '<p id="address-details"><b>' + res.bedroom + "bd | "+res.bathroom+"br | " + res.square_feet + "sqft </b></p>"
            $('#address-details').replaceWith(addressDetails)

            var addressDescription = '<p id="address-description">' + res.description + '</p>'
            $('#address-description').replaceWith(addressDescription)

            if (res.rent == false){
              var addressListType = '<p>'
            }


          }
        })
        $('#modal1').modal('open');
      });

  }
}
