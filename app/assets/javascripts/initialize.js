$(document).ready(function(){

	var mapView = new MapWidget.View(L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13));
  var mapController = new MapWidget.Controller(mapView);


  var searchBarController = new SearchBarWidget.Controller(mapView)

  var tabController = new TabBarWidget.Controller();



$('form.new_truck').submit(function(e) {
  e.preventDefault();

  $.ajax({
    type: 'POST',
    url: '/addtruck',
    data: $(this).serialize()
  }).done(function() {
   // document.getElementById("new_truck").reset();
   $('#newtruckform form')[0].reset();
   $('#newtruckform').hide();
   // console.log(response)
 })
})



});
