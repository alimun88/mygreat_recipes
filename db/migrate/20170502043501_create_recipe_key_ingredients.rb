class CreateRecipeKeyIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_key_ingredients do |t|
      t.integer :recipe_id
      t.integer :key_ingredient_id
    end
  end
end
