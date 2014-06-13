class TrucksController < ApplicationController
  respond_to :json

  def index
	@trucks = Truck.where(approved: true, active: true)
	@current_trucks = @trucks.select { |truck| truck.has_current_location? }
	@unknown_trucks = @trucks - @current_trucks

    # @geojson = []
    @geojson = [
  {
    type: "Feature",
    geometry: {
      type: "Point",
      coordinates: [-77.03238901390978,38.913188059745586]
    },
    properties: {
      title: "Mapbox DC",
      description: "1714 14th St NW, Washington DC",
      :'marker-color' => "#6c6c6c",
      :'marker-size' => "small",
      :'marker-symbol' => "bus"
    }
  },
  {
    type: "Feature",
    geometry: {
      type: "Point",
      coordinates: [-122.414, 37.776]
    },
    properties: {
      title: "Mapbox SF",
      description: "155 9th St, San Francisco",
      :'marker-color' => "#6c6c6c",
      :'marker-size' => "small",
      :'marker-symbol' => "bus"
    }
  }
]



  render :json => @geojson.to_json

  end


end

