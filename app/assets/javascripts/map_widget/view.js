MapWidget.View = function() {
	this.map = L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13);
	this.layer = L.mapbox.featureLayer().addTo(this.map);
	this.currentTrucks = [];	
	this.grabCurrentTruckMarkers();
	this.draw();
};

MapWidget.View.prototype = {
	draw: function() {

		this.layer.on('layeradd', function(e) {
			var marker = e.layer,
					feature = marker.feature;

			marker.setIcon(L.icon(feature.properties.icon));

		});

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
	},

	grabCurrentTruckMarkers: function() {
		var self = this;
		$.ajax({
			type: "get",
			url: "/trucks/new.json",
			dataType: 'json'
		}).done(function(response){
				for (var i =0; i < response.length; i++) {
					self.currentTrucks.push(response[i]);
				}
			});
	},

	searchTruckMarkersOnMap: function(searchString) {
		for (var i=0; i < this.currentTrucks.length; i++) {
			if (this.currentTrucks[i].properties.title.toLowerCase() == searchString) {
				return true;
			}
		}
		return false
	},


	redraw: function(searchString) {
		for (var i=0; i < this.currentTrucks.length; i++) {
			if (this.currentTrucks[i].properties.title.toLowerCase() == searchString) {
				var newCoordinates = this.currentTrucks[i].geometry.coordinates;
				this.map.setView([newCoordinates[1], newCoordinates[0]], [15]);
				this.openPopUp(searchString);
			}
		}
	},

	openPopUp: function(searchString) {
		console.log('hi')
		this.layer.eachLayer(function(marker){
			if (marker.feature.properties.title.toLowerCase() === searchString){
				marker.openPopup();
			}
		})
	}


};

