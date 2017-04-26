class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Message sent Successfully"
       redirect_to new_contact_path
    else
       render new_contact_path
    end
  end
  
  private
  
  def contact_params
     params.require(:contact).permit(:fname, :lname, :email, :comments)
  end
end