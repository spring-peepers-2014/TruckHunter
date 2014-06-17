// jasmine.getFixtures().fixturesPath = "assets/;

// beforeEach(function() {
//   $('#html-fixtures').html('<div id='map' class='dark'></div>');
// });




describe("a searchbar widget controller", function() {

	it("is instantiable", function() {
		expect(SearchBarWidget.Controller).toBeDefined();
	});


	// it("is initialized with a view", function() {
	// 	loadFixtures("myfixture.html")
	// 	var newview = new MapWidget.View(L.mapbox.map('map', 'inslee.igapaca7').setView([40.75, -73.97], 13));
	// 	var searchbarwidget = new SearchBarWidget.Controller(newview);
	// 	expect(searchbarwidget.view).toBeDefined();
	// });

	it("should not grab any trucks on the map with no view", function() {
		var searchbarwidget = new SearchBarWidget.Controller();
		searchbarwidget.grabTruckMarkers();
		expect(searchbarwidget.currentTrucks).toEqual([]);
	});

	it("should search for the food truck marker on the map based on user search", function() {
		var searchbarwidget = new SearchBarWidget.Controller();
		expect(searchbarwidget.searchTruckMarkersOnMap("this is not on the map")).toBeFalsy();

	});

	// it("should send coordinates to the view"), function() {
	// 	var searchbarwidget = new SearchBarWidget.Controller();
	// 	searchbarwidget.searchedTruckMarker = "yo";
	// 	expect(searchbarwidget.searchedTruckMarker).toEqual("yo");

	// });

	// it("should find food trucks", function() {
	// 	var searchbarwidget = new SearchBarWidget.Controller();
	// 	searchbarwidget.findFoodTrucks();
	// 	expect(searchbarwidget.foodTrucks).toEqual([])
	// }

});
