class Api::V1::UsersController < ApplicationController
  before_action :requires_login, only: [:user_search_histories]
  before_action :requires_user_match, only: [:user_search_histories]

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

  def user_search_histories
    render json: @user.search_histories
  end

  def user_watchlists
    render json: @user.watchlists
  end

  def user_portfolio_assets
    render json: @user.portfolio_assets
  end
end
