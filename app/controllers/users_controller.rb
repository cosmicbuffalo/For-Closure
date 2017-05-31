class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)

  end

  def get_user_modal

    render partial: 'sign_in_chunk.html.erb'

  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params

      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone1, :phone2, :phone3)

    end



end
