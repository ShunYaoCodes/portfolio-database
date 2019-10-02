class Api::V1::UsersController < ApplicationController
  def index
  end

  def show
  end

  def create
    @user = User.new

    @user.username = params[:username]
    @user.password = params[:password]

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
