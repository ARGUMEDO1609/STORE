class Authentication::UsersController < ApplicationController
    def new 
      @user = User.new
    end
  
    def create 
  @user = User.new(user_params)
     redirect_to products_path, notice: 'created'
  if @user.save

  else 
    render :new, status: :unprocessable_entity
  end
  end

  private 

  def user_params 
    params.require(:user).permit(:email, :username, :password)
  end
end