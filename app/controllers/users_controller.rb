class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = @user.assess_params(params)
  end


  # I don't think we need this actually
  def destroy
    @user = User.find(params[:id])
    @user.delete_user
  end
end
