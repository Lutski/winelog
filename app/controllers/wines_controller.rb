class WinesController < ApplicationController
  before_action :find_wine, only: [:show, :edit, :update, :destroy]

  def index
    @wines = Wine.all
  end

  def show
  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.create(wine_params)

    if @wine.save
      redirect_to @wine
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @wine.update(wine_params)
      redirect_to @wine
    else
      render 'edit'
    end
  end

  def destroy
    @wine.destroy
    redirect_to root_path
  end

  private

  def wine_params
      params.require(:wine).permit(:title, :vintage, :brand, :description, :extracomments, :image)
  end

  def find_wine
    @wine = Wine.find(params[:id])
  end
end
