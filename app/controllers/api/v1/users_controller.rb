class Api::V1::UsersController < ApplicationController
  before_action :requires_login, only: [:index, :show, :update]
  before_action :requires_user_match, only: [:index, :show, :update]

  def index
    @users = User.all
    render json: @users
  end

  def show
    if is_authenticated?
      @user = User.find(params[:id])
      render json: @user
    end
  end

  def create
    @user = User.new

    @user.email = params[:email]
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if (@user.save)
      token = generate_token

      render json: {
        token: token,
        id: @user.id
      }
    else
      render json: {
        error: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    @user.investment_amount = params[:investment_amount]
    @user.save!(validate: false)
  end

  def destroy
  end
end