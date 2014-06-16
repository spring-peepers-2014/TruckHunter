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
	},

	redraw: function(truckMarker) {
		var mapLoad = this.map;
		var coordinates = truckMarker.geometry.coordinates;
		mapLoad.setView([coordinates[0], coordinates[1]]);
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
