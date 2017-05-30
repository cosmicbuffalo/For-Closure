class MapsController < ApplicationController
  def index
    @homes = Property.all
  end
end
