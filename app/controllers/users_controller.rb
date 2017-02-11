class UsersController < ApplicationController
   
   #get request made to users/user_id
   def show
    @user = User.find(params[:id])
   end
end