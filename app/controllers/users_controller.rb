class UsersController < ApplicationController
   
   before_action :authenticate_user!
   #get request made to users/user_id
   def show
    @user = User.find(params[:id])
   end
   
   def index
     @users = User.includes(:profile)
     
   end
end