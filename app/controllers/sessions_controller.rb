class SessionsController < ApplicationController
  def index
  end

  def new
  end

  def create

    @user = User.find_by(email:login_params[:email]).try(:authenticate, login_params[:password])

    if @user
      session[:user_id] = @user.id
      session[:user_coords] = [login_params[:latitude], login_params[:longitude]]
      puts login_params
      return render json: {result:"success", coords:session[:user_coords]}
    else
      flash[:errors] = ["Incorrect email or password. Please try again."]
      return render json: {result:"failure"}
    end


  end

  private
    def login_params
      params.require(:login).permit(:email, :password, :latitude, :longitude)
    end
end
