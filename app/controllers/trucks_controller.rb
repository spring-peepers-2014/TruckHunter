class TrucksController < ApplicationController
  respond_to :json

  def index
	@trucks = Truck.where(approved: true, active: true)
	@current_trucks = @trucks.select { |truck| truck.has_current_location? }
	@unknown_trucks = @trucks - @current_trucks

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

