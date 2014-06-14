MapWidget.View = function() {
	this.map = L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13);
};

MapWidget.View.prototype = {
	draw: function() {
		this.map;
	};
};