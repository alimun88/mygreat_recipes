class PagesController < ApplicationController
  
  def home
    @recipes = Recipe.paginate(page: params[:page], per_page: 3)
    redirect_to recipes_path if logged_in?
    
  end
  
  def about
  end
  
end
