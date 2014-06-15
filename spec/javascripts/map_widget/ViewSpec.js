describe("A View", function() {
  
  beforeEach(function() {
  	viewer = new MapWidget.View();
  });

  it("should be defined", function() {
    expect(viewer).toBeDefined();
  });

  it("should have set up map", function() {
  	expect(viewer.map).toBeDefined();
  });

  describe("#draw", function() {

  	it("should make an AJAX request to the correct URL", function() {
    	spyOn($, "ajax");
    	MapWidget.View.map();
    	expect($.ajax.mostRecentCall.args[0]["url"]).toEqual("/trucks/new.json");
		});

  });



});
