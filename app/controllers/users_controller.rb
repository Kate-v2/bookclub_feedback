class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = @user.assess_params(params)
  end
end
