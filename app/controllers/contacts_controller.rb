class ContactsController < ApplicationController
   
   # Creates instance of Contact object (Get request to /contact-us)
   # Show new contact form
   def new
      @contact = Contact.new
   end
   
   # creates instance of Contact object with parameters. 
   def create
      @contact = Contact.new(contact_params) # assigns form fields into Contact Object
      if  @contact.save 
         #if @contact form saves correctly, redirect to new contact/new and give them a message
         
         #assign these variables to the parameter values after verification.
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         
         # params is how you can access those values.
         
         #email method and send mail
         ContactMailer.contact_email(name, email, body).deliver
         
         #Store success message in flash hash
         flash[:success] = "message sent."
         #redirect to new action
         redirect_to contact_us_path
      else
         # Stores errors in flash hash and redirect to new action.
         flash[:danger] = @contact.errors.full_messages.join(", ") # creates clean error message
         redirect_to contact_us_path
      end
      
      
   end 
   
      #private function
   private 
   
   #To collect data from form, we need ot use
   #Strong parameters and whitelist the form fields.
      def contact_params
         params.require(:contact).permit(:name, :email, :comments)
      end
end

