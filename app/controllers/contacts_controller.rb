class ContactsController < ApplicationController
   def new
      @contact = Contact.new
   end
   
   # creates instance of Contact object with parameters. 
   def create
      @contact = Contact.new(contact_params)
      if  @contact.save 
         #if @contact form saves correctly, redirect to new contact/new and give them a message
         
         #assign these variables to the parameter values after verification.
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         # params is how you can access those values.
         
         #send these variables to contact_email
         ContactMailer.contact_email(name, email, body).deliver
         
         flash[:success] = "message sent."
         redirect_to contact_us_path
      else
         flash[:danger] = @contact.errors.full_messages.join(", ") # creates clean error message
         redirect_to contact_us_path
      end
      
      
   end 
   
      #private function
   private 
      def contact_params
         #Security functionality
         params.require(:contact).permit(:name, :email, :comments)
      end
end

