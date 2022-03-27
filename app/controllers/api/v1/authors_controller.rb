class Api::V1::AuthorsController < ApplicationController
  before_action :find_author, only: [:show, :update, :destroy]
  
  def index 
    render json: Author.all 
  end

  def show
    render json: @author
  end

  def create 
    render json: Author.create!(author_params)
  end

  def update 
    render json: @author.update(author_params)
  end

  def destroy 
    render json: @author.destroy
  end

  private 

    def author_params 
      params.require(:author).permit(:first_name, :last_name)
    end

    def find_author
      @author = Author.find(params[:id])
    end
end