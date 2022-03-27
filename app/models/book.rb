class Book < ApplicationRecord
  validates :title, :genre, :summary, :popularity, presence: true
  validates :number_sold, presence: true, numericality: true 
  
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
