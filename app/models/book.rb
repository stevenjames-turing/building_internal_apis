
class Book < ApplicationRecord
  # Model Validations
  validates :title, :genre, :summary, :popularity, presence: true
  validates :number_sold, presence: true, numericality: true 
  
  # Model Relationships
  belongs_to :author
  
  # Call_back for V2 API adding popularity to DB
  before_save { |book| book.popularity = calculate_popularity }

  private 
    def calculate_popularity
      if number_sold > 5
        'high'
      else 
        'low'
      end
    end
end
