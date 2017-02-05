class ContactsController < ApplicationController
   def new
      @contact = Contact.new
   end
   
   # creates instance of Contact object with parameters. 
   def create
      @contact = Contact.new(contact_params)
      if  @contact.save 
         #if @contact form saves correctly, redirect to new contact/new and give them a message
         flash[:success] = "message sent."
         redirect_to new_contact_path
      else
         flash[:error] = @contact.errors.full_messages.join(", ") # creates clean error message
         redirect_to new_contact_path
      end
   end 
   
      #private function
   private 
      def contact_params
         #Security functionality
         params.require(:contact).permit(:name, :email, :comments)
      end
end

