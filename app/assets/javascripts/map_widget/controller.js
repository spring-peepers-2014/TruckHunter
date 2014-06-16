MapWidget.Controller = function(view) {
	this.view = view;
	this.currentTrucks = [];
	this.grabTruckMarkers();
	this.searchedTruckMarker = '';
};


MapWidget.Controller.prototype = {
	grabTruckMarkers: function() {
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
				this.searchedTruckMarker = this.currentTrucks[i]
				return true;
			}
		}
		return false
	},

	sendCoordinates: function() {
		var newCoordinates =this.searchedTruckMarker.geometry.coordinates;
		console.log(newCoordinates)
		this.view.redraw(newCoordinates, this.searchedTruckMarker);
	}

};