class MapsController < ApplicationController
  layout 'maps.html.erb'
  def index
    # set these sessions to the proper geolocations
    session[:latitude] = 41.896862899999995
    session[:longitude] = -87.6344093
  
  end


  def query

    @maps = Property.all

    render json: @maps.to_json(:include => :images)
  end
  def new
    @image = Property.all
    
  end

  def create

    @image = Image.new(image: params[:image], imageable: Property.first)
    @image.save
    return redirect_to '/maps/new'

  end



  def info

    @property = Property.find(params["id"])
    @property_images = @property.images
    render partial: 'partials/listing_details.html.erb'
  end

private
  def image_params
    params.require(:image).permit(:image)
  end
end
