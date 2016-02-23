class WinesController < ApplicationController
  def index
    @wines = Wine.all
  end

  def show
    @wine = Wine.find(params[:id])
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
  end

  def destroy

  end

  private

  def wine_params
      params.require(:wine).permit(:title, :vintage, :brand, :description, :extracomments, :image)
  end
end
