$(document).ready(function(){

	var mapView = new MapWidget.View();
  var mapController = new MapWidget.Controller(mapView);


  var searchBarController = new SearchBarWidget.Controller(mapView)

  $('.newtrucktab').on('click', function(){
    $('.opened').show();
  });


  $(document).on('click', '#close', function(e){
    $('#popup').remove();
  })

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
