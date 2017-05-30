class UsersController < ApplicationController
  def new
    @user = User.new
  end  

  def create
    @user = User.create(user_params)  
    if @user.valid?
      redirect_to "/users/show/#{@user.id}"
    else
      redirect_to '/users/new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:first_name,:email,:password,:picture)
    end

end
