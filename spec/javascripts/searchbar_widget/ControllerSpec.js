

describe("a searchbar widget controller", function() {

	it("is instantiable", function() {
		expect(SearchBarWidget.Controller).toBeDefined();
	});


	xit("is initialized with a view", function() {
		loadFixtures("myfixture.html")
		var newview = new MapWidget.View(L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13));
		var searchbarwidget = new SearchBarWidget.Controller(newview);
		expect(searchbarwidget.view).toBeDefined();
	});

	it("should not grab any trucks on the map with no view", function() {
		var searchbarwidget = new SearchBarWidget.Controller();
		searchbarwidget.grabTruckMarkers();
		expect(searchbarwidget.currentTrucks).toEqual([]);
	});

	it("should search for the food truck marker on the map based on user search", function() {
		var searchbarwidget = new SearchBarWidget.Controller();
		expect(searchbarwidget.searchTruckMarkersOnMap("this is not on the map")).toBeFalsy();

	});

	xit("should not send coordinates with no view", function() {
		var searchbarwidget = new SearchBarWidget.Controller();
		expect(searchbarwidget.sendCoordinates()).toThrowError();
	});

	it("should not find food trucks with no view", function() {
		var searchbarwidget = new SearchBarWidget.Controller();
		expect(searchbarwidget.foodTrucks).toEqual([]);
	});

});
