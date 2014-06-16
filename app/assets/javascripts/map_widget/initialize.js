$(document).ready(function(){

	var mapView = new MapWidget.View();


$('#searchform').on('submit', function(e){
  e.preventDefault();
  var searchString = $('input[name="foodtruck"]').val().toLowerCase();
  if (mapView.searchTruckMarkersOnMap(searchString)) {
    mapView.redraw();
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
