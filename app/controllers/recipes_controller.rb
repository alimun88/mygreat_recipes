class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy, :like]
  before_action :require_chef, except: [:index, :show, :like]
  before_action :require_chef_like, only: [:like]
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
    if @recipe.save!
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
    @comment = Comment.new
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deletedd Successfully"
    redirect_to recipes_path
  end
  
  def like
    like = Like.create(like: params[:like], chef: current_chef, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was succesful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :ingedients, :description, :image, key_ingredient_ids: [])
  end
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def require_chef_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
  end
  
  def require_same_chef
    if current_chef != @recipe.chef and !current_chef.admin?
      flash[:danger] = "You can only edit or delete your own recipes"
      redirect_to recipes_path
    end
  end

end
