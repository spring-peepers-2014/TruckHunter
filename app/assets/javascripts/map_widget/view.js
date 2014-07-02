MapWidget.View = function(map) {
	this.map = map;
	this.layer = L.mapbox.featureLayer().addTo(this.map);
	this.draw();
  	this.userLocator();
};

MapWidget.View.prototype = {
	draw: function() {

		this.layer.on('layeradd', function(e) {
			var marker = e.layer,
			feature = marker.feature;

			marker.setIcon(L.icon(feature.properties.icon));

		});

		this.layer.loadURL('/trucks/new.json');
    
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

		map.on('locationfound', function(e) {
			map.fitBounds(e.bounds).setView([e.latlng.lat, e.latlng.lng],15);

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

		geolocate.parentNode.removeChild(geolocate);
		});

		map.on('locationerror', function() {
			geolocate.innerHTML = 'Position could not be found';
		});
	},

	redraw: function(searchedMarker, newCoordinates) {
			this.map.setView([newCoordinates[1], newCoordinates[0]], [15]);
			this.openPopUp(searchedMarker);
	},

	openPopUp: function(searchedMarker) {
		var self = this;
		this.layer.eachLayer(function(marker){
			if (marker.feature.properties.title == searchedMarker.properties.title){
				marker.openPopup();
			}
    });
	},

	closePopUp: function(){
		var self = this;
		this.layer.eachLayer(function(marker){
			marker.closePopup();
    });
	},

	renderPartial: function(searchString) {
		$.ajax({
			type: 'post',
			url: '/searchbar',
			data: {name: searchString}
		}).done(function(response){
			$('#header').append(response);
		});
	},

	closeEverything: function() {
		$('#usersubmit').hide();
		$('#truckowner').hide();
		$('#usersubmitform').hide();
		$('#truckownerreadme').hide();	
		$('#popup').hide();
	}

};

