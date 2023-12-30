class Authentication::SessionsController < ApplicationController
    def new 
    end
  
    def create 
       @user = User.find_by("email = :login OR username = :login", { login: params[:login] }) 
       
       if @user&.authenticate(params[:password])
        redirect_to products_path, notice: 'Welcome !'
       else

       end
#      redirect_to products_path, notice: 'created'

#   if @user.save
#   else 
#     render :new, status: :unprocessable_entity
#   end
  end

#   private 

#   def user_params 
#     params.require(:user).permit(:email, :username, :password)
#   end
end