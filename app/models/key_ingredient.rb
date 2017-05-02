class KeyIngredient < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates_uniqueness_of :name
  has_many :recipe_key_ingredients
  has_many :recipes, through: :recipe_key_ingredients
  
end