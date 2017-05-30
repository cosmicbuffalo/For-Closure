class MapsController < ApplicationController
  def index
    # set these sessions to the proper geolocations
    session[:latitude] = 41.896862899999995
    session[:longitude] = -87.6344093
    @homes = Property.all
  end
end
