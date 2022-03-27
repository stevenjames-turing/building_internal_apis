class Api::V1::BooksController < ApplicationController
  before_action :find_author, only: [:index, :create]
  before_action :find_book_and_author, only: [:show, :update]

  def index
    render json: Book.all 
  end
  
  def show
    render json: @book
  end
  
  def create
    render json: Book.create(book_params)
  end

  def update 
    render json: @book.update(book_params)
  end

  def destroy 
    render json: Book.delete(params[:id])
  end

  private 

    def book_params 
      params.require(:book).permit(:title, :author_id, :summary, :genre, :number_sold)
    end

    def find_author
      @author = Author.find(params[:author_id])
    end
    
    def find_book_and_author
      @book = Book.find(params[:id])
      @author = Author.find(params[:author_id])
    end
end