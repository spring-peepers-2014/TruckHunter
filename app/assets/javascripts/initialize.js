$(document).ready(function(){

	var map = new MapWidget.View();
	map.draw();

<<<<<<< HEAD
  console.log('searching')
  map.searchMarkersOnMap("Shortys NYC");



//on form submit, grab the truck that the user is searching for
  $('#searchform').on('submit', function(e){
      e.preventDefault();
      var searchString = $('input[name="foodtruck"]').val();
      // searchDatabase(searchString);
      // console.log("inside form")
      // console.log(map.currentTrucks)
      // console.log("what is feature layer")
      // console.log(map.map.featureLayer)
      console.log("press enter!")
      searchMarkersOnMap(searchString);
      // if (searchMarkersOnMap(searchString)){
      //   console.log("this is true")
      //   var truckMarker = grabMarker(searchString);
      //   console.log("what is truckmarker")
      //   console.log(truckMarker)
      //   map.redraw(truckMarker);
      // }
    })


 // function searchMarkersOnMap(searchString) {
 //    console.log('inside')
 //    for (var i=0; i < map.currentTrucks.length; i++) {
 //      // if (map.currentTrucks[i].properties.name === searchString) {
 //      //   return true;
 //      // }
 //      // else {
 //      //   return false;
 //      //   }
 //      console.log('inside for loop')
 //      console.log(map.currentTrucks)
 //    }
 //  };


  function grabMarker(searchString) {
    for (var i=0; i< map.currentTrucks.length ; i++){
      if (map.currentTrucks[i].properties.name == searchString) {
        return map.currentTrucks[i];
      }
    }
  }




  	
=======
>>>>>>> af1127a4aa5db71457fa2f45c3a685b5e623a3e3
	$('.newtrucktab').on('click', function(){
		$('.opened').show();
	});


});