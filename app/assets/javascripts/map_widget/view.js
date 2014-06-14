MapWidget.View = function() {
	this.map = L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13);

};

MapWidget.View.prototype = {

	draw: function() {
		var mapLoad = this.map;

		$.ajax({
    type: "get",
    url: "/trucks.json",
    dataType: 'json'
		}).done(function(response){
				L.mapbox.featureLayer(response).addTo(mapLoad);
			});
	}
};
