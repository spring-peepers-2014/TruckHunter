class TrucksController < ApplicationController
  respond_to :json

  def index
    "you"
    @geojson = []
    @geojson << {
    type: 'Feature',
    geometry: {
      type: 'Point',
      coordinates: [40.7184,-74]
    },
    properties: {
      name: "Nirav shit",
      address: "34 st",
      :'marker-color' => '#00607d',
      :'marker-symbol' => 'circle',
      :'marker-size' => 'medium'
    }
  }



  render :json => @geojson.to_json

  end


end
