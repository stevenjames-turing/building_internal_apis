class Author < ApplicationRecord
  # Model Validations 
  validates :first_name, :last_name, presence: true 
end
