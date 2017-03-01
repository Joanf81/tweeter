class Api::V1::UsersController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :update, :tweets]

  # GET /users
  def index
    respond_to do |format|
      format.all { render json: User.all, status: :ok  }
    end
  end

  # GET /users/1
  def show
    respond_to do |format|
      format.all { render json: @user, status: :ok }
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.all { render json: @user, status: :created }
      else
        format.all { render json: {errors: @user.errors}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.all { head :no_content, status: :ok }
      else
        format.all { render json: {errors: @user.errors}, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/tweets
  def tweets
    respond_to do |format|
      format.all { render json: @user.tweets.order(:created_at).reverse_order.as_json(include: {user: {only: :username}, tags: {:only => [:tag, :id]}}, methods: :type), status: :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      respond_to do |format|
        format.all { render json: {errors: {user: ['The user with id=' + params[:id] + ' does not exist.']}}, status: :not_found }
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :username)
  end
end
