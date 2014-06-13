// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.jsr

$(document).ready(function(){
  var map = L.mapbox.map('map', 'inslee.igapaca7');
  // map.featureLayer.on('click', function(e) {
  //        map.panTo(e.layer.getLatLng());
  //    });
  $.ajax({
    type: "get",
    url: "/trucks.json",
    dataType: 'json'
  }).done(function(response) {
    console.log(response[0].geometry.coordinates)
    L.marker(response[0].geometry.coordinates).addTo(map)
    .bindPopup(response[0].properties.name)

  });

});
