class KeyIngredientsController < ApplicationController
  
  before_action :set_ingredient, only: [:edit, :update, :show]
  before_action :require_admin, except: [:show, :index]
  
  def index
    @ingredients = KeyIngredient.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @ingredient = KeyIngredient.new
  end
  
  def create
    @ingredient = KeyIngredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient was created Successfully"
      redirect_to key_ingredient_path(@ingredient)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update 
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingredient was updated Successfully"
      redirect_to key_ingredient_path(@ingredient)
    else
      render 'edit'
    end
  end
  
  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  private
   
  def ingredient_params 
    params.require(:key_ingredient).permit(:name)
  end
  
  def set_ingredient
    @ingredient = KeyIngredient.find(params[:id])
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_chef.admin?)
      flash[:danger] = "Only admin users can perform that action"
      redirect_to key_ingredients_path
    end
  end
    
end