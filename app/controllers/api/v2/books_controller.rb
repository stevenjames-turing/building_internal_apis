class Api::V2::BooksController < ApplicationController
  before_action :find_author, only: [:index]

  def index 
    books = Book.all
    render json: BookSerializer.format_books(books)
  end

  private 

    def find_author
      @author = Author.find(params[:author_id])
    end
end