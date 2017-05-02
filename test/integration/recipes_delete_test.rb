require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chef_name: "mohammad", email: "mohammad@example.com",
                              password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", ingedients: "oil 1/3 cup, carrot 2, cabbage 1/4th cup",
              description: "great vegetable sautee, add vegetable and oil", chef: @chef)
  end

  test "successfully delete a recipe" do
    sign_in_as(@chef, "password")
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this Recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end
