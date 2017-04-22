class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe was successfully created"
      redirect_to recipes_path(@recipe)
    else
      flash[:danger] = "Failed to create Recipe"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe was successfully Updated"
      redirect_to recipes_path(@recipe)
    else
      flash[:danger] = "Failed to update Recipe"
      render 'new'
    end
  end
  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end

end
