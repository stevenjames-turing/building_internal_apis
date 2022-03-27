class Api::V1::AuthorsController < ApplicationController
  def index 
    render json: Author.all 
  end
end