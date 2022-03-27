class Api::V1::AuthorsController < ApplicationController
  before_action :find_author, only: [:show]
  
  def index 
    render json: Author.all 
  end

  def show
    render json: @author
  end

  private 

    def find_author
      @author = Author.find(params[:id])
    end
end