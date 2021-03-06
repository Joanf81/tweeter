class Api::V1::TweetsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_tweet, only: [:show, :update, :destroy, :tags, :addtag, :deletetag]
  before_action :set_tag, only: [:deletetag]
  before_action :create_new_tweet, only: [:create]

  # GET /tweets
  def index
    respond_to do |format|
      format.all { render json: Tweet.all.order(:created_at).reverse_order.as_json(include: {user: {only: :username}, tags: {:only => [:tag, :id]}}, methods: :type), status: :ok }
    end
  end

  # GET /tweets/1
  def show
    respond_to do |format|
      format.all { render json: @tweet.as_json(include: {user: {only: :username}, tags: {:only => [:tag, :id]}}, methods: :type), status: :ok }
    end
  end

  # POST /tweets
  def create
    respond_to do |format|
      if @new_tweet.save
        format.all { render json: @new_tweet, status: :created }
      else
        format.all { render json: {errors: @new_tweet.errors}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.all { head :no_content, status: :ok }
      else
        format.all { render json: {errors: @tweet.errors}, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.tags.all.each do |t|
      tag = Tag.find_by(id: t.id)
      if tag.tweets.count == 1
        tag.destroy
      end
    end

    @tweet.destroy

    respond_to do |format|
      format.all { render json: {}, status: :ok }
    end
  end

  # GET /tweets/1/tags
  def tags
    respond_to do |format|
      format.all { render json: @tweet.tags.order(:created_at).as_json, status: :ok }
    end
  end

  # POST /tweets/1/tags
  def addtag
    if Tag.exists?(tag: params[:tag]) # If the tag exists in the db..

      if !@tweet.tags.exists?(tag: params[:tag]) # If the tag is not associated with the tweet..
        @tweet.tags << Tag.find_by(tag: params[:tag])
      end

      respond_to do |format|
        format.all { render json: {}, status: :ok }
      end

    else # If the tag does not exists..
      @tag = Tag.new({tag: params[:tag]})

      respond_to do |format|
        if @tag.save # If the tag has no errors
          @tweet.tags << @tag
          format.all { render json: @tag, status: :created }
        else
          format.all { render json: {errors: @tag.errors}, status: :unprocessable_entity }
        end
      end

    end
  end

  # DELETE /tweets/1/tags/1
  def deletetag
    if @tweet.tags.exists?(@tag.id) # If the tag is included in the tweet..

      @tweet.delete_tag(@tag.id)

      respond_to do |format|
        format.all { render json: {}, status: :ok }
      end

    else
      respond_to do |format|
        format.all { render json: {errors: {tweet: ['The tweet does not contain the tag with id='+@tag.id.to_s+'.']}}, status: :not_found }
      end
    end
  end



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      if Tweet.exists?(params[:id])
        @tweet = Tweet.find(params[:id])
      else
        respond_to do |format|
          format.all { render json: {errors: {tweet: ['The tweet with id=' + params[:id] + ' does not exist.']}}, status: :not_found }
        end
      end
    end

    def set_tag
      if Tag.exists?(params[:idtag])
        @tag = Tag.find(params[:idtag])
      else
        respond_to do |format|
          format.all { render json: {errors: {tag: ['The tag with id=' + params[:idtag] + ' does not exist.']}}, status: :not_found }
        end
      end
    end


    # Creates a new tweet with type and user_id
    def create_new_tweet
      if params[:tweet][:type] != nil && params[:tweet][:type].gsub(/\s+/, '') != '' # gsub-> Delete the spaces character for assert if the type really defined
        begin
          @new_tweet = Tweet.new(tweet_params.merge(:type => params[:tweet][:type], :user_id => params[:tweet][:user_id]))
        rescue => e
          respond_to do |format|
            format.all { render json: {errors: {tweet: 'The type or the user id are invalids.'}}, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.all { render json: {errors: {tweet: 'The type must be present.'}}, status: :unprocessable_entity }
        end
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:text, :url)
    end
end
