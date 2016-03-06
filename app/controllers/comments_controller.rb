class CommentsController < ApplicationController
  before_action :find_wine
  before_action :authenticate_user!
  before_action :comment_owner

  def create
    @comment = @wine.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id if current_user
    @comment.save

    if @comment.save
      redirect_to wine_path(@wine)
    else
      render 'new'
    end
  end

  def destroy
    @comment = @wine.comments.find(params[:id])
    @comment.destroy
    redirect_to wine_path(@wine)
  end

  def edit
    @comment = @wine.comments.find(params[:id])
  end

  def update
    @comment = @wine.comments.find(params[:id])

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

  def comment_owner
    @comment = @wine.comments.find(params[:id])
    unless @comment.user_id == current_user.id
      flash[:notice] = "You shall not pass!"
      redirect_to @wine
    end
  end

end
