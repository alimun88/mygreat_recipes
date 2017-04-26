class AddIngredientsToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :ingedients, :string
  end
end
