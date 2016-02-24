class WinesController < ApplicationController
  before_action :find_wine, only: [:show, :edit, :update, :destroy, :wine_post_owner]
  before_action :authenticate_user!, except: [:index, :show, :recent, :oldest]
  before_action :wine_post_owner, only: [:edit, :update, :destroy]

  def index
    @wines = Wine.all.order("created_at DESC")
  end

  def recent
    @wines = Wine.recent
    render action: :index
  end

  def oldest
    @wines = Wine.oldest
    render action: :index
  end

  def my_library
    if !current_user.nil?
      @wines = current_user.wines
    end
  end

  def show
  end

  def new
    @wine = current_user.wines.build
  end

  def create
    @wine = current_user.wines.build(wine_params)

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
      params.require(:wine).permit(:title, :vintage, :brand, :description, :extracomments, :image, :country, :region, :grape, :rating)
  end

  def find_wine
    @wine = Wine.find(params[:id])
  end

  def wine_post_owner
    unless @wine.user_id == current_user.id
      flash[:notice] = "You shall not pass!"
      redirect_to @wine
    end
  end
end
