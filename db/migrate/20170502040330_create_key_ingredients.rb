class CreateKeyIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :key_ingredients do |t|
      t.string :name
    end
  end
end
