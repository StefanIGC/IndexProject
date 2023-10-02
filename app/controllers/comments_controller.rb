class CommentsController < ApplicationController
  
  before_action :set_comment, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /comments
  def index
    @comments = Comment.all
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    # @comment = Comment.find(params[:id])

    unless current_user == @comment.user
      render json: { error: 'You are not authorized to edit this article.' }, status: :unauthorized
      return
    end

    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    unless current_user == @comment.user
      render json: { error: 'You;re not authorized to delete this article!' }, status: :unauthorized
      return
    end
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :rating, :user_id, :article_id)
    end
end
