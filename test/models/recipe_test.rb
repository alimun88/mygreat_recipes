require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create!(chef_name: "rahman", email: "rahman@example.com",
                              password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.new(name: "new Recipe", ingedients: "Vegetable, some cube", description: "This is for vegetable soup")
    @recipe.save
  end
  
  test "recipe should be invalid without chef_id" do
    @recipe.chef_id = " "
    assert_not @recipe.valid?
  end
  
  test "recipe should be valid" do
     assert @recipe.valid? 
  end   
  
  test "name should be valid" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "ingedients should be valid" do
    @recipe.ingedients = " "
    assert_not @recipe.valid?
  end
  
  test "description should be valid" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description should not be less than 5 " do
    @recipe.description = "a" * 4
    assert_not @recipe.valid?
  end
  
  test "description should not be more than 1500 " do
    @recipe.description = "a" * 1501
    assert_not @recipe.valid?
  end
  
end