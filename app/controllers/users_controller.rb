class UsersController < ApplicationController
   
   before_action :authenticate_user!
   #get request made to users/user_id
   def show
    @user = User.find(params[:id])
   end
end