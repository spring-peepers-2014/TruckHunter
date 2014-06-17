MapWidget.Controller = function(view) {
	
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
			self.view.hideLoader();
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
		this.view.redraw(this.searchedTruckMarker, newCoordinates);
	},



///////auto completition methods

	findFoodTrucks: function() {
		var self = this;
		$.ajax({
			type: 'get',
			url: '/searchbar/new',
			dataType: 'json'
		}).done(function(response){
			var namesofFoodTrucks = response
			for (var i=0; i < namesofFoodTrucks.length; i++) {
				self.foodTrucks.push({ value: namesofFoodTrucks[i]});
			}
		})
	},
};	



