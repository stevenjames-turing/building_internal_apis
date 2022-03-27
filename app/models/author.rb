class Author < ApplicationRecord
  # Model Validations 
  validates :first_name, :last_name, presence: true 

  # Model Relationships
  has_many :books, dependent: :destroy
  
end
