class CommentsController < ApplicationController
  before_action :find_wine
  before_action :authenticate_user!
  before_action :find_comment, only: [:destroy, :edit, :update]
  before_action :comment_owner, only: [:edit, :destroy]

  def create
    @comment = @wine.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to wine_path(@wine)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to wine_path(@wine)
  end

  def edit
  end

  def update
    if @comment.update(params[:comment].permit(:content))
      redirect_to wine_path(@wine)
    else
      render 'edit'
    end
  end


  private

  def find_wine
    @wine = Wine.find(params[:wine_id])
  end


  def find_comment
    @comment = @wine.comments.find(params[:id])
  end

  def comment_owner
    unless @comment.user_id == current_user.id
      flash[:notice] = "You shall not pass!"
      redirect_to @wine
    end
  end
end
