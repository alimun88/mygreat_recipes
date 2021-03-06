require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chef_name: "mohammad", email: "mohammad@example.com",
                         password: "password", password_confirmation: "password")
    @recipe = Recipe.create!(name: "vegetable saute", ingedients: "vegetable and saute", 
                    description: "great vegetable saute, and vegetable oil", chef: @chef)
  end
  
  test "reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", ingedients: " ",
                                                 description: "some description" } } 
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end  
  
  test "successfully edit a recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), 
                       params: { recipe: { name: updated_name, ingedients: "updated ingedients",
                                   description: updated_description } }
    assert_redirected_to @recipe
    #follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end
    
end
