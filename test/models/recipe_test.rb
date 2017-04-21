require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @recipe = Recipe.new(name: "new Recipe", description: "This is for vegetable soup")
  end
  
  test "recipe should be valid" do
     assert @recipe.valid? 
  end   
  
  test "name should be valid" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "description should be valid" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description should not be less than 5 " do
    @recipe.description = "a" * 5
    assert_not @recipe.valid?
  end
  
  test "description should not be more than 500 " do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
end