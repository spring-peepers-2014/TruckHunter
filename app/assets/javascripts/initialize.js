$(document).ready(function(){
  var map = L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13);
  var mapView = new MapWidget.View(map);
  var mapController = new MapWidget.Controller(mapView);
  var searchBarController = new SearchBarWidget.Controller(mapView);
  var eventListener = new EventListener(mapView);

});
