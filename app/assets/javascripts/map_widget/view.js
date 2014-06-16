MapWidget.View = function() {
	this.map = L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13);
	this.layer = L.mapbox.featureLayer().addTo(this.map);
	this.currentTrucks = [];
};

MapWidget.View.prototype = {


	// draw: function() {
	// 	var mapLoad = this.map;
	// 	var self = this
	// 	$.ajax({
 //    type: "get",
 //    url: "/trucks/new.json",
 //    dataType: 'json'
	// 	}).done(function(response){
	// 			L.mapbox.featureLayer(response).addTo(mapLoad);
				
	// 			for (var i =0; i < response.length; i++){
	// 				self.currentTrucks.push(response[i])
	// 			}

	// 			// console.log(response)
	// 			// self.currentTrucks = response;
	// 			// console.log("inside")
	// 			// console.log(self.currentTrucks)
	// 			// var coordinates = self.currentTrucks[0].geometry.coordinates
	// 			// console.log(coordinates[0])
	// 			// console.log(coordinates[1])
	// 		});


	draw: function() {
		this.layer.loadURL('/trucks/new.json');
		this.userLocator();
	},

	userLocator: function() {

		var geolocate = document.getElementById('geolocate');
		var map = this.map;
		var myLayer = L.mapbox.featureLayer().addTo(map);

		if (!navigator.geolocation) {
			geolocate.innerHTML = 'Geolocation is not available';
		} else {
			geolocate.onclick = function (e) {
			e.preventDefault();
			e.stopPropagation();
			map.locate();
};
		}

		// Once we've got a position, zoom and center the map
		// on it, and add a single marker.
		map.on('locationfound', function(e) {
			map.fitBounds(e.bounds);

      myLayer.setGeoJSON({
        type: 'Feature',
        geometry: {
            type: 'Point',
            coordinates: [e.latlng.lng, e.latlng.lat]
        },
        properties: {
            'title': 'Here I am!',
            'marker-color': '#ff8888',
            'marker-symbol': 'star'
        }
      });
// And hide the geolocation button
			geolocate.parentNode.removeChild(geolocate);
		});

		// If the user chooses not to allow their location
		// to be shared, display an error message.
		map.on('locationerror', function() {
			geolocate.innerHTML = 'Position could not be found';
		});
	}

	// searchMarkersOnMap: function(searchString) {
	// 	console.log('inside searchMarkerMap function')
	// 	console.log(this)
	// 	console.log(this.map)
	// 	console.log(this.currentTrucks.call())
	// 	console.log(this.draw)
	//     for (var i=0; i < this.currentTrucks.length; i++) {
	//       console.log('inside for loop')
	//       console.log(this.currentTrucks)
	//     }
 //  	}






};

