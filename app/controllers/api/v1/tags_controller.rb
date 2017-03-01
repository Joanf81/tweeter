class Api::V1::TagsController < ApplicationController
  before_action :set_tag, only: [:tweets]

  # GET /tags
  def index
    respond_to do |format|
      format.all { render json: Tag.get_all_tags_ordered_by_popularity.as_json(methods: :times_used), status: :ok }
    end
  end

  # GET /tags/1/tweets
  def tweets
    respond_to do |format|
      format.all { render json: @tag.tweets.order(:created_at).reverse_order.as_json(include: {user: {only: :username}, tags: {:only => [:tag, :id]}}, methods: :type), status: :ok }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      if Tag.exists?(params[:id])
        @tag = Tag.find(params[:id])
      else
        respond_to do |format|
          format.all { render json: {errors: {tag: ['The tag with id=' + params[:id] + ' does not exist.']}}, status: :not_found }
        end
      end
    end
end
