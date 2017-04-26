require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
    
    def setup
      @chef = Chef.create!(chef_name: "mashrur", email: "mashrur@example.com")
      @recipe = Recipe.create!(name: "vegetable saute", ingedients: "vegetable and saute", 
                      description: "great vegetable saute, and vegetable oil", chef: @chef)
      @recipe2 = @chef.recipes.build(name: "chicken saute", ingedients: "chicken cube",
                                                         description: "great chicken dish within 20 min")
      @recipe2.save
    end
    test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
    test "should get recipes listing" do
      get recipes_path
      assert_template 'recipes/index'
      assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
      assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    end
    
    test "should get recipes show" do
      get recipe_path(@recipe)
      assert_template 'recipes/show'
      assert_match @recipe.name, response.body
      assert_match @recipe.ingedients, response.body
      assert_match @recipe.description, response.body
      assert_match @chef.chef_name, response.body
    end
    
    test "create new valid recipe" do
      get new_recipe_path
      assert_template 'recipes/new'
      name_of_recipe = "chicken saute"
      name_of_ingredient = "chichen and vegetablew",
      description_of_recipe = "add chicken, add vegetables, cook for 20 minutes, serve delicious meal"
      assert_difference 'Recipe.count' do
        post recipes_path, params: { recipe: { name: name_of_recipe, ingedients: name_of_ingredient,
                                                       description: description_of_recipe}}
      end
      follow_redirect!
      assert_match name_of_recipe.capitalize, response.body
      assert_match name_of_ingredient, response.body
      assert_match description_of_recipe, response.body
    end
    
    test "reject invalid recipe submissions" do
      get new_recipe_path
      assert_template 'recipes/new'
      assert_no_difference 'Recipe.count' do
        post recipes_path, params: { recipe: { name: " ", ingedients: " ", description: " " } }
      end
      assert_template 'recipes/new'
      assert_select 'h2.panel-title'
      assert_select 'div.panel-body'
    end
end
