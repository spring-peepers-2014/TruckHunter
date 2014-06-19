xdescribe("A View", function() {


  beforeEach(function() {
    var map = L.mapbox.map('map').setView([40.75, -73.97], 13);
    var viewer = new MapWidget.View(map);
  });

  it("creates a new instance", function(){
    expect(viewer).toBeDefined();
  });

  it("should be initialized with map", function() {
    expect(viewer.map).toBeDefined();

  });
  
  it("should be initialized with layer", function() {
    expect(viewer.layer).toBeDefined();

  });

  describe("#draw", function() {

    it("should display map", function() {
      expect(viwer.draw).toBeDefined();

    });

  });

  describe("#userLocator", function() {

    it("", function() {

    });

  });

  describe("#redraw", function() {

    it("", function() {

    });

  });


  describe("#openPopUp", function() {

    it("", function() {

    });

  });

  describe("#colsePopUp", function() {

    it("", function() {

    });

  });

  describe("#renderPartial", function() {

    it("", function() {

    });

  });


});
