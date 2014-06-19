$(document).ready(function(){
  var map = L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13);
	
  // var loader = document.getElementById('loader');
  
  // startLoading();

  // L.mapbox.tileLayer('inslee.igapaca7')
  //     .addTo(map) // add your tiles to the map
  //     .on('load', finishedLoading); // when the tiles load, remove the screen

  var mapView = new MapWidget.View(map);

  var mapController = new MapWidget.Controller(mapView);

  var searchBarController = new SearchBarWidget.Controller(mapView);

  var tabController = new TabBarWidget.Controller();


  function startLoading() {
      loader.className = '';
  }

  function finishedLoading() {
      // first, toggle the class 'done', which makes the loading screen
      // fade out
      loader.className = 'done';
      setTimeout(function() {
          // then, after a half-second, add the class 'hide', which hides
          // it completely and ensures that the user can interact with the
          // map again.
          loader.className = 'hide';
      }, 500);
  }


  $('form.new_truck').submit(function(e) {
    e.preventDefault();

    $.ajax({
      type: 'POST',
      url: '/addtruck',
      data: $(this).serialize()
    }).done(function() {
     document.getElementById("new_truck").reset();
     $('#usersubmitform').hide();
   })
  })


});
