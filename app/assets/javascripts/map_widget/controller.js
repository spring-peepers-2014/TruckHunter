MapWidget.Controller = function(view) {
	this.view = view;
	this.currentTrucks = [];
	this.grabTruckMarkers();
	this.listenForSearch();
	this.searchedTruckMarker = '';

	this.foodTrucks = [];
	this.findFoodTrucks();
	this.autoCompleteThis();
};	


MapWidget.Controller.prototype = {

	listenForSearch: function() {
		var self = this;
		$('#searchform').on('submit', function(e){
			e.preventDefault();
			var searchString = $('input[name="foodtruck"]').val().toLowerCase();
			 if (self.searchTruckMarkersOnMap(searchString)) {
    			self.sendCoordinates();
  			}
		});
	},


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


	autoCompleteThis: function() {
		$('#autocomplete').autocomplete({
			lookup: this.foodTrucks
		})
	}

};