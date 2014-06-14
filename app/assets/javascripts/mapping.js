
var addPin = function(map) {
  $.ajax({
    type: "get",
    url: "/trucks.json",
    dataType: 'json'
  }).done(function(response) {
    console.log(response);
    map.featureLayer.setGeoJSON(response);

	};
}
