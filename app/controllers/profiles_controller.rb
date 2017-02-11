class ProfilesController < ApplicationController
    # GET to /users/:user_id/profile/new 
    def new
    #When this happens, render blank profile details form.
    @profile = Profile.new
    end
    
    # POST request /users/:user_id/profile
    def create
        #Ensure user who fills out form
       @user = User.find(params[:user_id])
       #Create profile linked to this user.
       @profile = @user.build_profile(profile_params ) # pre-fills user_id via "Build_profile" 
      if @profile.save
          flash[:success] = "Profile Updated!"
          redirect_to user_url(params[:user_id])
      else
          render action :new
      end
    end
    
    #Get requests for Editing Profile. 
    def edit 
        @user = User.find(params[:user_id])
        @profile = @user.profile
    end
    
    
    private 
        def profile_params
            #whitelist form fields.
           params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
        end
end
