// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.jsr

$(document).ready(function(){
  // var map = L.mapbox.map('map', 'inslee.igapaca7');
  // map.featureLayer.on('click', function(e) {
  //        map.panTo(e.layer.getLatLng());
  //    });
  $.ajax({
    type: "get",
    url: "/trucks.json",
    dataType: 'json'
  }).done(function(response) {
    console.log(response)
    L.mapbox.map('map', 'inslee.igapaca7')
    .setView([40.75, -73.97], 13)
    .featureLayer.setGeoJSON(response);


  });

});
