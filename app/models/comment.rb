class Comment < ApplicationRecord
  validates :comments, presence: true, length: { minimum: 20, maximum: 300}
  belongs_to :chef
  belongs_to :recipe
  validates :chef_id, presence: true
  validates :recipe_id, presence: true
  default_scope -> {order( updated_at: :desc)}
  
end