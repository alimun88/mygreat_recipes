class Recipe < ApplicationRecord
  validates :name , presence: true
  validates :ingedients, presence: true, length: { minimum: 5, maximum: 1500 }
  validates :description , presence: true, length: { minimum: 6, maximum: 2500 }
  validates :chef_id, presence: true
  belongs_to :chef
  default_scope -> {order( updated_at: :desc)}
end