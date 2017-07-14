

function set_user_coords() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(sendPos);
  } else {
    alert("Geolocation is not supported by this browser.");
  }
}
function sendPos(position) {

  $.post({
    url: '/sessions/location',
    data: { 'latitude': position.coords.latitude, 'longitude': position.coords.longitude },
    success: function (res) {
      if (res.result == "success") {
        alert("Successfuly set location: " + String(res.coords))
        location.reload
      } else {
        alert(res.message)
      }

    }
  })
}



var map;

function initMap() {

  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: { lat: Number($('#hiddenDiv').attr("latitude")), lng: Number($('#hiddenDiv').attr("longitude")) }
    //
  });

  renderQueryset(map)


}


function renderQueryset(map) {
  $.get({
    url: '/listings/query',
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


    if (res[i].rent) {
      var priceString = "$" + res[i].price + "/mo"
    }
    else {
      var priceString = "$" + res[i].price
    }
    var marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      animation: google.maps.Animation.DROP,
      icon: new google.maps.MarkerImage($('#hiddenDiv').attr("marker"),
        null, /* size is determined at runtime */
        null, /* origin is 0,0 */
        null, /* anchor is bottom center of the scaled image */
        new google.maps.Size(25, 25)
      ),
      propId: res[i].id

    })
    try {
      var content = '<img  src="' + res[i].images[0].image.url + '"alt= "Nothin" height="45">';
    }

    catch (err) {
      var content = '<img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png" alt= "Nothin" height="45">'
    }

    content += '<div class="hover-info"><ul> <li>' + priceString + "</li><br>" + "<li>" + res[i].bedroom + "bd | " + res[i].bathroom + "br</li><br>" + "<li>" + res[i].square_feet + " sqft </li>" + "</div>";
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

    google.maps.event.addListener(marker, 'click', function (position) {
      console.log(this.propId)
      $.get({
        url: '/listings/info',
        data: { "id": this.propId },
        success: function (res) {
          $('#modal1').html(res)
          $('.materialboxed').materialbox();
        }
      })
      $('#modal1').modal('open');

    });


    google.maps.event.addListener($('#map-search-button'), "click", function (e) {
      e.preventDefault()
      console.log('yay')
    });

  }
}

function tileClick() {
  $("#listings-sidebar").on('click', ".property-tile", function () {

    console.log($(this).attr('property-id'))
    $.get({
      url: "/listings/info",
      data: { "id": $(this).attr('property-id') },
      success: function (res) {
        $('#modal1').html(res)
        $('.materialboxed').materialbox();
      }

    })
    $('#modal1').modal('open');
  })
}

function newLocation(newLat, newLng) {
  console.log('fdfadsf');//25.7616798, -80.1917902
  map.panTo({ lat: newLat, lng: newLng });
}


$(document).on('turbolinks:load', function () {
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('#modal1').modal();
  $('.materialboxed').materialbox();

  tileClick()

  $('#header').css('padding-left', '0px')


  if ($('#location-check').attr('have-location') == 'false') {
    console.log("couldn't find location, running set_user_coords")
    set_user_coords();
  } else {
    console.log("location is already present")
  }


  $('.property-tile .favorite').on("click", function (e) {

    e.stopPropagation()
    console.log($('#logged-in').attr('is-logged-in'))
    if ($('#logged-in').attr('is-logged-in') == "true") {



      if ($(this).children().attr("style") == 'color:white') {

        $(this).children().remove()
        var htmlString = '<i class="small material-icons star-favorites" style="color:#0074e4">grade</i>'
        $(this).append(htmlString)
      }

      else {
        $(this).children().remove()
        var htmlString = '<i  class="small material-icons star-favorites" style="color:white" >grade</i>'
        $(this).append(htmlString)
      }

      var propertyId = $(this).parent().attr('property-id')
      $.post({
        url: "/listings/favorite",
        data: { "prop_id": propertyId },
        dataType: "json",
        success: function (res) {
          console.log("yay")
        }
      })
    }


    else {
      alert("You gotta be logged on to do that silly!")
    }

  })











  $(document).on("click", '#map-search-button', function (e) {
    e.preventDefault();
    console.log($("#search-bar-input").serialize());
    $.post({
      url: '/listings/partial_search',
      data: $("#search-bar-input").serialize(),
      dataType: 'json',
      success: function (res) {
        console.log(res);
        newLocation(res[0], res[1]);

      }
    })
  })
});
