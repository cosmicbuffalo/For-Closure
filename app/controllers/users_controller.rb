class UsersController < ApplicationController
  def new

  end  

  def create
    @user = User.create(user_params)
    Image.create(imageable_id: params[:image],imageable_type:"User")
    
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
      params.require(:user).permit(:name,:email,:password)
    end

end
