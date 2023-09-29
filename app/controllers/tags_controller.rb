class TagsController < ApplicationController
  
  before_action :set_tag, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /tags
  def index
    @tags = Tag.all
    authorize! :read, @tags
    render json: @tags
  end

  # GET /tags/1
  def show
    # authorize! :read, @tags
    render json: @tag
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    authorize! :create, @tags
    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    authorize! :create, @tags
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    authorize! :destroy, @tags
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
