class CommentsController < ApplicationController
  
  before_action :set_comment, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /comments
  def index
    @comments = Comment.all
    authorize! :read, @comments
    render json: @comments
  end

  # GET /comments/1
  def show
    authorize! :read, @comments
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    authorize! :create, @comments
    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    authorize! :create, @comments
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    authorize! :destroy, @comments
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
