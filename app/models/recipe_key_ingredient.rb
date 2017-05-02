class RecipeKeyIngredient < ApplicationRecord
  belongs_to :key_ingredient
  belongs_to :recipe
end