class MapsController < ApplicationController
  layout 'maps.html.erb'
  def index
    # set these sessions to the proper geolocations
    puts session[:latitude]
    puts session[:longitude]
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
