window.listingMarker = null;

window.loadPin = function loadPin() {
  console.log("Yes its me!");
  var listingLatLong = new google.maps.LatLng(window.latitude,window.longitude);

  map.setCenter(listingLatLong);
  map.setZoom(16);

  if (listingMarker) {
    listingMarker.setMap(null);
    listingMarker = null;
  }

  window.listingMarker = new google.maps.Marker({
    map       : map,
    draggable : true,
    animation : google.maps.Animation.DROP,
    position  : listingLatLong
  });

  google.maps.event.addListener(listingMarker, 'drag', function() {
    document.getElementById('listing_longitude').value = listingMarker.getPosition().lng();
    document.getElementById('listing_latitude').value = listingMarker.getPosition().lat();
  });

  google.maps.event.addListener(listingMarker, 'dragend', function() {
    document.getElementById('listing_longitude').value = listingMarker.getPosition().lng();
    document.getElementById('listing_latitude').value = listingMarker.getPosition().lat();
  });

}

window.onload = function() {

  function initialize() {

    var latlng = new google.maps.LatLng(window.latitude, window.longitude);
    var mapOptions = {
      zoom: 16,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    window.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    loadPin();
  }
  
  jQuery( document ).ready(function() {
    initialize();
  });
}