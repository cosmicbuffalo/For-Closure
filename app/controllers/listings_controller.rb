class ListingsController < ApplicationController
 layout 'maps.html.erb'
  def index
    # set these sessions to the proper geolocations
    puts session[:latitude]
    puts session[:longitude]
    @properties = Property.all

  end


  def query

    @maps = Property.all

    render json: @maps.to_json(:include => :images)
  end
  def new
    @image = Property.all

  end

  def create

    # params.permit(images: [])[:images].each do |image|
    #   @image = Image.new(image: image, imageable: Property.first)
    #   @image.save
    # end
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
