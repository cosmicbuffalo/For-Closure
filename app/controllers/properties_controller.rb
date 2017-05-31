class PropertiesController < ApplicationController

  def start_listing

    @property = Property.new(property_params)

    puts @property.inspect

    session[:property_in_progress] = property_params

    redirect_to '/properties/new'

  end

  def new
    return redirect_to '/listings/new' unless session[:property_in_progress]

    @property = Property.new(session[:property_in_progress])

    render 'edit.html.erb'

  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private
    def property_params
      raw = params.require(:property).permit(:address, :unit, :city, :state, :zipcode, :beds, :baths, :sq_feet, :price, :rent, :description, :home_type_id)
      property_params = {
        zipcode: raw[:zipcode],
        address: raw[:address] + " " + raw[:city] + ", " + raw[:state]
      }
      if session[:user_id]
        property_params[:user_id] = session[:user_id]
      end
      if raw[:unit]
        property_params[:unit] = raw[:unit]
        property_params[:address] = raw[:address] + " " + raw[:unit] + " " + raw[:city] + ", " + raw[:state]
      end

      if raw[:beds]
        property_params[:bedroom] = raw[:beds]
      end
      if raw[:baths]
        property_params[:bathroom] = raw[:baths]
      end
      if raw[:sq_feet]
        property_params[:sq_feet] = raw[:sq_feet]
      end
      if raw[:price]
        property_params[:price] = raw[:price]
      end
      if raw[:rent]
        property_params[:rent] = raw[:rent]
      end
      if raw[:description]
        property_params[:description] = raw[:description]
      end
      if raw[:home_type_id]
        property_params[:home_type] = HomeType.find(raw[:home_type_id])
      end

      return property_params
    end


end
