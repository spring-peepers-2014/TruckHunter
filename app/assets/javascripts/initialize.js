$(document).ready(function(){

	var mapView = new MapWidget.View();
	// mapView.draw();
  // mapView.grabMarkers();
  // console.log(mapView)
  // console.log(mapView.currentTrucks)






//on form submit, grab the truck that the user is searching for
$('#searchform').on('submit', function(e){
  e.preventDefault();
  var searchString = $('input[name="foodtruck"]').val();
  console.log("press enter!");
  if (mapView.searchMarkersOnMap(searchString)) {
    console.log('yay');
    mapView.redraw(searchString);
  }
});



$('.newtrucktab').on('click', function(){
  $('.opened').show();
});


});

