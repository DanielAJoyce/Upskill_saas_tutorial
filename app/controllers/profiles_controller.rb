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
       @profile = @user.build_profile(profile_params ) 
      if @profile.save
          flash[:success] = "Profile Updated!"
          redirect_to root_path
      else
          render action :new
      end
    end
    
    
    private 
        def profile_params
            #whitelist form fields.
           params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
        end
end
