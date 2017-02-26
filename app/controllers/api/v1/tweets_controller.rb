class Api::V1::TweetsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_tweet, only: [:show, :update, :destroy]
  before_action :create_new_tweet, only: [:create]

  # GET /tweets
  def index
    respond_to do |format|
      format.all { render json: Tweet.all.as_json(include: {user: {only: :username}}, methods: :type), status: :ok }
    end
  end

  # GET /tweets/1
  def show
    respond_to do |format|
      format.all { render json: @tweet.as_json(include: {user: {only: :username}}, methods: :type), status: :ok }
    end
  end

  # POST /tweets
  def create
    if @new_tweet != nil
      respond_to do |format|
        if @new_tweet.save
          format.all { render json: @new_tweet, status: :created }
        else
          format.all { render json: {errors: @new_tweet.errors}, status: :unprocessable_entity }
        end
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
    @tweet.destroy
    respond_to do |format|
      format.all { render json: {}, status: :ok }
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


    # Evaluates the user params and creates a new tweet, ready to save
    def create_new_tweet

      @new_tweet = nil

      # Extract the 'content_type' param and create a type of tweet depending of this param
      if params[:tweet][:content_type] == 'image'
        @new_tweet = ImageTweet.new(tweet_params)
      elsif params[:tweet][:content_type] == 'text'
        @new_tweet = TextTweet.new(tweet_params)

        # Example of adding an audio tweet type. (You must create a new model class AudioTweet extending Tweet, exemplified in 'models/tweet.rb')
        #
        # elsif params[:tweet].content_type == 'audio'
        #   @tweet = AudioTweet.new(tweet_params)
      end

      if @new_tweet != nil

        #Add a user_id param and END!
        @new_tweet.user_id = params[:tweet][:user_id]
        ################################################################################

      else # If the content_type param wasn't correct...
        respond_to do |format|
          format.all { render json: {errors: {content_type: ['The content_type must be "image" or "text"']}}, status: :unprocessable_entity }
        end
      end

    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:text, :url)
    end
end
