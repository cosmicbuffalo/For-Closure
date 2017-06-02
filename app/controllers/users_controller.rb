class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    puts @user.inspect
    if @user.save
      session[:user_id] = @user.id
      unless session[:user_coords]
        session[:user_coords] = [coords_params[:latitude], coords_params[:longitude]] if coords_params[:latitude] && coords_params[:longitude]
      end
      return render json: {result:"success"}

    else
      flash[:errors] = @user.errors.full_messages
      return render json: {result:"failure", loc:"register"}

    end

  end

  def get_user_modal

    puts params

    if params["loc"] == 'register'
      @register = true

      if params['professional_info'] && params['professional_info'] == 'true'
        @professional_info = true
      end

    end

    render partial: 'partials/user_modal.html.erb'

  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params

      raw = params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone1, :phone2, :phone3, :zipcode, :landlord_agent, :category)
      puts raw.inspect
      user_params = {
        email: raw[:email],
        password: raw[:password],
        password_confirmation: raw[:password]
      }
      # puts raw["landlord_agent"].inspect
      if raw[:landlord_agent] == 'true'
        # puts 'landlord_agent is true'
        user_params[:first_name] = raw[:first_name]
        user_params[:last_name] = raw[:last_name]
        user_params[:phone_number] = raw[:phone1].to_s + "-" + raw[:phone2].to_s + "-" + raw[:phone3].to_s
        user_params[:zipcode] = raw[:zipcode]
        if raw[:category] && raw[:category] == "agent"
          user_params[:agent] = true
        elsif raw[:category] && raw[:category] == 'landlord'
          user_params[:landlord] = true
        end

      else
        puts "didn't find landlord_agent to be true"
      end
      puts "new user params:", user_params
      return user_params

    end

    def coords_params
      params.require(:login).permit(:latitude, :longitude)

    end



end
