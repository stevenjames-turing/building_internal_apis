class Api::V2::BooksController < ApplicationController
  
  def index 
    render json: Book.all
  end
end