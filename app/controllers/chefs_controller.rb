class ChefsController < ApplicationController
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chef_name} to myRecipe app!"
      redirect_to chef_path(@chef)
    else
       render 'new' 
    end
  end
  
  def edit
    @chef = Chef.find(params[:id])
  end
  
  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated Successfully"
      redirect_to @chef
    else
      render 'edit'
    end
  end
  
  def show
   @chef = Chef.find(params[:id])
   @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end
  private
  
  def chef_params
    params.require(:chef).permit(:chef_name, :email, :password, :password_confirmation)
  end
end
