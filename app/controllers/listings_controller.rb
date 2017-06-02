class ListingsController < ApplicationController
 layout 'maps.html.erb'
  def index
    # set these sessions to the proper geolocations
    
    @properties = Property.all

  end

  def search
   
    if params[:input_search].present?
        puts "*********************"
        puts params[:input_search]
        puts "*********************"

      @coordinates = Geocoder.coordinates(params[:input_search])
      if @coordinates
        puts @coordinates[0]
        puts @coordinates[1]
        puts session[:search_coords]
        session[:search_coords] = @coordinates
      else
        puts "not working!"
      end
    end
    return redirect_to '/listings'
  end

  def partial_search
    @look_up_location = Geocoder.coordinates(params[:location])
    render json: @look_up_location

  end



  def favorite

    property = Property.find(params["prop_id"])
    user = User.find(session[:user_id])
    favorite = Favorite.find_by(user: user, property: property)
    if favorite
      favorite.destroy
    else 
      new_favorite = Favorite.create(user: user, property: property)
    end 




    render json: {result: 'success'}
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
