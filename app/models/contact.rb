class Contact < ActiveRecord::Base
  
  validates :fname, presence: true
  validates :lname, presence: true
  validates :email, presence: true
  validates :comments, presence: true

end