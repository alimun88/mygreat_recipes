class Recipe < ApplicationRecord
  validates :name , presence: true
  validates :ingedients, presence: true, length: { minimum: 5, maximum: 1500 }
  validates :description , presence: true, length: { minimum: 6, maximum: 2500 }
  validates :chef_id, presence: true
  belongs_to :chef
  default_scope -> {order( updated_at: :desc)}
  has_many :recipe_key_ingredients
  has_many :key_ingredients, through: :recipe_key_ingredients
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  def thumbs_down_total
    self.likes.where(like: false).size    
  end
  
  mount_uploader :image, ImageUploader
  #validate :image_size
  
  private
  # Server-sided check only, not browser
  def image_size
    if image_size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end
end