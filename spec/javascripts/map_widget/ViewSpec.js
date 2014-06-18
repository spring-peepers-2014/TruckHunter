describe("A View", function() {


  beforeEach(function() {
    viewer = new MapWidget.View(map);
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

    it("should display map", function() {

    });

  });


  describe("#openPopUp", function() {

    it("should display map", function() {

    });

  });

  describe("#clsePopUp", function() {

    it("should display map", function() {

    });

  });

  describe("#renderPartial", function() {

    it("should display map", function() {

    });

  });


});
