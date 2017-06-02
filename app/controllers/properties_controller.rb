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

    puts "property in progress: ", session[:property_in_progress].inspect

    render 'edit.html.erb'

  end

  def create
    puts params.inspect

    params.each do |key, value|
      puts "  key:", key, "  value:", value
    end

    puts property_params.inspect

    @property = Property.new(property_params)

    if @property.save
      session[:property_in_progress] = nil

      category_params.each do |category, display|

        @category = Category.find_by_category(category)
        unless @category
          @category = Category.create(category:category, display:display)
        end
        Categorization.create(property:@property, category:@category)
        # begin
        #   @category = Category.find_by_category(category)
        # rescue
        #   @category = Category.create(category:category, display:display)
        # ensure
        #   Categorization.create(property:@property, category:@category)
        # end
      end

      return redirect_to '/maps/index'
    else
      flash[:errors] = @property.errors
      return redirect_to '/properties/new'
    end


    redirect_to '/properties/new'
  end

  def show
  end

  def edit
  end

  def update
  end

  def test

    render json: category_params

  end

  private
    def property_params
      raw = params.require(:property).permit(:address, :unit, :city, :state, :zipcode, :beds, :baths, :sq_feet, :price, :rent, :description, :home_type_id, :rooms, :contact_number)
      property_params = {
        zipcode: session[:property_in_progress] ? session[:property_in_progress]['zipcode'] : raw[:zipcode],
        address: session[:property_in_progress] ? session[:property_in_progress]['address'] : raw[:address] + " " + raw[:city] + ", " + raw[:state]
      }
      if session[:user_id]
        property_params[:user_id] = session[:user_id]
      end
      if raw[:unit]
        property_params[:unit] = raw[:unit]
        property_params[:address] = raw[:address] + " " + raw[:unit] + " " + raw[:city] + ", " + raw[:state]

      elsif session[:property_in_progress]
        property_params[:unit] = session[:property_in_progress]['unit']
      end

      if raw[:beds]
        property_params[:bedroom] = raw[:beds]
      end
      if raw[:baths]
        property_params[:bathroom] = raw[:baths]
      end
      if raw[:sq_feet]
        property_params[:square_feet] = raw[:sq_feet]
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
      if raw[:rooms]
        property_params[:rooms] = raw[:rooms]
      end

      if session[:property_in_progress]
        session[:property_in_progress].each do |key, value|
          property_params[key] = value
        end
      end

      return property_params
    end

    def category_params

      params.require(:category)

    end


end
