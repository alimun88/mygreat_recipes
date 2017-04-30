class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy]
  before_action :require_chef, except: [:index, :show]
  before_action :require_same_chef, only: [:edit, :update, :destroy]
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      flash[:success] = "Recipe was successfully created"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was successfully Updated"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def show
    
  end
  
  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deletedd Successfully"
    redirect_to recipes_path
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :ingedients, :description)
  end
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def require_same_chef
    if current_chef != @recipe.chef
      flash[:danger] = "You can only edit or delete your own recipes"
      redirect_to recipes_path
    end
  end

end
