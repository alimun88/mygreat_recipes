class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_chef, :logged_in?
  
  def current_chef
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    !!current_chef
    
  end
  
  def require_chef
    if !logged_in?
      flash[:danger] = "You have to logged_in in order to perform this action"
      redirect_to root_path
    end
  end
end
