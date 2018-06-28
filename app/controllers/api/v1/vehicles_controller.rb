class Api::V1::VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]

  def_param_group :vehicle do
    param :company_id, String, :desc => "Company's vehicle identification"
  end
  
  param_group :vehicle
  api :GET, "vehicles", "Show all vehicles"
  def index
    @vehicles = Vehicle.all.includes(:locations)
    
    render json: @vehicles 
  end

  param_group :vehicle
  api :GET, "vehicles/:id", "Show a vehicle details"
  def show
    render json: @vehicle
  end

  param_group :vehicle
  api :POST, "vehicles", "Create a vehicle"
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  param_group :vehicle
  api :PUT, "vehicles/:id", "Edit a vehicle"
  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "vehicles/:id", "Delete a vehicle"
  def destroy
    @vehicle.destroy
  end

  param_group :vehicle
  api :GET, "vehicles/company_id/:company_id", "Find a vehicle by his company_id"
  def show_by_company_id
    @vehicle = Vehicle.find_by('lower(company_id) ILIKE ?', "%" + params[:company_id].downcase+"%")
    
    if @vehicle
      render json: @vehicle
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  param_group :vehicle
  api :GET, "vehicles/available", "Show all vehicles who are not active"
  def show_available

    @itineraries = Itinerary.all
    @vehicles = Vehicle.all
    
    @availables = []

    @vehicles.each do |vehicle|
      flag = false
      @itineraries.each do |itinerary|
        if vehicle.id == itinerary.vehicle_id
          flag = true
        end
      end
      if !flag
        @availables.push(vehicle)
      end
    end
    render json: @availables
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.required(:vehicle).permit(:company_id)
    end
end
