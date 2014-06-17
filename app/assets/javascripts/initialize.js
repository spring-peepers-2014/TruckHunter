$(document).ready(function(){

	var mapView = new MapWidget.View();
  var mapController = new MapWidget.Controller(mapView);
  // var autoCompleteController = new AutoComplete.Controller()


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
