class TrucksController < ApplicationController
  respond_to :json

  def index
    "you"
    @geojson = []
    @geojson << {
    type: 'Feature',
    geometry: {
      type: 'Point',
      coordinates: ["73.9857", "40.7484"]
    },
    properties: {
      name: "Nirav shit",
      address: "34 st",
      :'marker-color' => '#00607d',
      :'marker-symbol' => 'circle',
      :'marker-size' => 'medium'
    }
  }
  end


end
