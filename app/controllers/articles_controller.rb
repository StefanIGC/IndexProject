class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /articles
  def index
    @articles = Article.where(deleted_at: nil)
    render json: @articles
  end

  # GET /articles/1
  def show
    if @article.deleted_at.nil?
      render json: @article.to_json(include: [:comments])
    else
      render json: { error: 'Article not found' }, status: :not_found
    end
  end

  # POST /articles
  def create
    article = current_user.articles.new(article_params)

    if article.save
      render json: article, status: :created, location: article
    else
      render json: article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    @article = Article.find(params[:id])

    unless current_user == @article.author
      render json: { error: 'You are not authorized to edit this article.' }, status: :unauthorized
      return
    end

    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article = Article.find(params[:id])
    unless current_user == @article.author
      render json: { error: 'You;re not authorized to delete this article!' }, status: :unauthorized
      return
    end

    @article.update(deleted_at: Time.current)
    render json: { article: 'Deleted!' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description, :image, :category_id, :tag_id, :author_id, :published)
    end
end
