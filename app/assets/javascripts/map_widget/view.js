MapWidget.View = function() {
	this.map = L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13);
	this.currentTrucks = '';

};

MapWidget.View.prototype = {

	draw: function() {
		var mapLoad = this.map;
		var self = this
		$.ajax({
    type: "get",
    url: "/trucks/new.json",
    dataType: 'json'
		}).done(function(response){
				L.mapbox.featureLayer(response).addTo(mapLoad);
				console.log(response)
				self.currentTrucks = response
				console.log("inside")
				console.log(self.currentTrucks)
				console.log(self.currentTrucks[0].properties.title)
			});
	}
};
