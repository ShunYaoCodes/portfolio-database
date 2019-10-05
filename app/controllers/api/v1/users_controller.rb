class Api::V1::UsersController < ApplicationController
  before_action :requires_login, only: [:index, :show]
  before_action :requires_user_match, only: [:index, :show]

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

    @user.username = params[:username]
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
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end
end
