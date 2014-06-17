$(document).ready(function(){

	var mapView = new MapWidget.View();
  var mapController = new MapWidget.Controller(mapView);



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

  // var counter = 0;
  // setInterval(function() {
  //   var frames=12; var frameWidth = 46;
  //   var offset=counter * -frameWidth;
  //   document.getElementById("loading").style.backgroundPosition=
  //       offset + "px" + " " + 0 + "px";
  //   counter++; if (counter>=frames) counter =0;
  // }, 100);


});
