class ChefsController < ApplicationController
  
  def index
    @chef = Chef.all
  end
  
  def new
    @chef = Chef.new
  end
end
