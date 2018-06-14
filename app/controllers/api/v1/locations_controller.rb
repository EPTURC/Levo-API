class Api::V1::LocationsController < ApplicationController
  before_action :set_vehicle
  before_action :set_location, only: %i[show]

  api :GET, "vehicles/:id_vehicle/locations", "Show all locations for the vehicle"
  def index
    @locations = @vehicle.locations
    render json: @locations.as_json(only: [:latitude, :longitude, :created_at])
  end

  api :GET, "vehicles/:id_vehicle/locations/:id", "Show a location details for the vehicle"
  def show
    render json: @location.as_json(only: [:latitude, :longitude, :created_at])
  end

  api :POST, "vehicles/:id_vehicle/locations", "Create a new location for the vehicle"
  def create
    @location = Location.new(location_params)
    @location.vehicle = @vehicle

    if @location.save
      render json: @location, status: :created, location: api_v1_vehicle_location_url(@vehicle, @location)
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  private
  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def set_location
      @location = @vehicle.locations.find(params[:id])
  end

  def location_params
    params.required(:location).permit(:latitude, :longitude)
  end

end


