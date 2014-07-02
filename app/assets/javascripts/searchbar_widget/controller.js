SearchBarWidget.Controller = function(view) {
	this.view = view;
	this.currentTrucks = [];
	this.grabTruckMarkers();
	this.listenForSearch();
	this.searchedTruckMarker = '';
	this.foodTrucks = [];
	this.findFoodTrucks();
	this.autoCompleteThis();
};	


SearchBarWidget.Controller.prototype = {

	listenForSearch: function() {
		var self = this;
		$('#searchform').on('submit', function(e){
			e.preventDefault();
			var searchString = $('input[name="foodtruck"]').val().toLowerCase();
			 if (self.searchTruckMarkersOnMap(searchString)) {
    			$('#popup').remove();
    			self.view.closeEverything();
    			self.sendCoordinates();
    		}
    		else {
    			$('#popup').remove();
    			self.view.closePopUp();
    			self.view.closeEverything();
    			self.view.renderPartial(searchString);
    		}
  			$('form')[0].reset();
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
		this.view.redraw(this.searchedTruckMarker, newCoordinates);
	},

///////auto completion methods
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