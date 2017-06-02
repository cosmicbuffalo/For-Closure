class SessionsController < ApplicationController

  layout 'maps.html.erb'
  
  def index
    session.delete(:search_coords)
    puts "*****************************"
    puts session[:search_coords]
  end

  def new
  end

  def create

    @user = User.find_by(email:login_params[:email]).try(:authenticate, login_params[:password])

    if @user
      session[:user_id] = @user.id

      unless session[:user_coords]
        session[:user_coords] = [login_params[:latitude], login_params[:longitude]] if login_params[:latitude] && login_params[:longitude]
      end
      # puts "login_params----->", login_params
      # puts "Session ------>", session[:user_coords]
      return render json: {result:"success", coords:session[:user_coords]}
    else
      flash[:errors] = ["Incorrect email or password. Please try again."]
      return render json: {result:"failure"}
    end


  end

  def set_user_coords
    puts params
    if params[:latitude] && params[:longitude]
      unless session[:user_coords]
        session[:user_coords] = [params[:latitude], params[:longitude]]
      end
      puts "set user coordinates to...", session[:user_coords]
      return render json: {result:"success", coords:session[:user_coords]}
    else
      return render json: {result:"failure", message:"Unable to retrieve location"}
    end

  end

  def destroy

    session.clear
    redirect_to '/home'

  end

  private
    def login_params
      params.require(:login).permit(:email, :password, :latitude, :longitude)
    end
end
