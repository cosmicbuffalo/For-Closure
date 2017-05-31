class MapsController < ApplicationController

  def index
    # set these sessions to the proper geolocations
    session[:latitude] = 41.896862899999995
    session[:longitude] = -87.6344093
  
  end


  def query
    @maps = Property.all
    render json: @maps
  end


  def info
    @info = Property.find(params["id"])
    render json: @info
  end
end
