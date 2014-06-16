$(document).ready(function(){

	var mapView = new MapWidget.View();
	// mapView.draw();
  // mapView.grabMarkers();
  // console.log(mapView)
  // console.log(mapView.currentTrucks)



//on form submit, grab the truck that the user is searching for
$('#searchform').on('submit', function(e){
  e.preventDefault();
  var searchString = $('input[name="foodtruck"]').val().toLowerCase();
  if (mapView.searchTruckMarkersOnMap(searchString)) {
    mapView.redraw(searchString);
  }
});



$('.newtrucktab').on('click', function(){
  $('.opened').show();
});


});

