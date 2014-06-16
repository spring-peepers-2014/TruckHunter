$(document).ready(function(){

	var mapView = new MapWidget.View();
  var mapController = new MapWidget.Controller(mapView);


$('#searchform').on('submit', function(e){
  e.preventDefault();
  var searchString = $('input[name="foodtruck"]').val().toLowerCase();
  if (mapController.searchTruckMarkersOnMap(searchString)) {
    mapController.sendCoordinates();
  }
});


$('.newtrucktab').on('click', function(){
  $('.opened').show();
});


$('form.new_truck').submit(function(e) {
  e.preventDefault();

  $.ajax({
    type: 'POST',
    url: '/addtruck',
    data: $(this).serialize()
  }).done(function() {
   document.getElementById("new_truck").reset();
   $('.opened').hide();
 })
})


});
