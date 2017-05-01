class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :update, :show, :destroy]
  before_action :require_same_chef, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.chef_name} to myRecipe app!"
      redirect_to chef_path(@chef)
    else
       render 'new' 
    end
  end
  
  def edit
    
  end
  
  def update
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated Successfully"
      redirect_to @chef
    else
      render 'edit'
    end
  end
  
  def show
   @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger] = "Chef and all associated recipes have been deleted"
      redirect_to chefs_path
    end
  end
  
  private
  
  def chef_params
    params.require(:chef).permit(:chef_name, :email, :password, :password_confirmation)
  end
  
  def set_chef
    @chef = @chef = Chef.find(params[:id])
  end
  
  def require_same_chef
    if current_chef != @chef and !current_chef.admin?
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to chefs_path
    end
  end
  
  def require_admin
    if logged_in? && !current_chef.admin?
      flash[:danger] = "Only admin users can perform this action"
      redirect_to root_path
    end
  end
  
end
