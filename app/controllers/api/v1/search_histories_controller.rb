class Api::V1::SearchHistoriesController < ApplicationController
  before_action :requires_login, only: [:index]

  def index
    # decode with the secret and the param set to true
    # get token from headers in request
    if is_authenticated?
      render json: SearchHistory.all
    else
      render json: {
        message: "No good"
      }, status: :unauthorized
    end
    #render json: SearchHistory.all
  end

  def show
    @search_histories = User.find(params[:id]).search_histories
    @symbols = []
    @search_histories.each do |history|
      @symbols << Asset.all.find{|asset| asset.id == history.asset_id}.symbol
    end
    render json: @symbols.reverse
  end

  def create
    @user = User.find(1)
    @asset = Asset.find_or_create_by(symbol: params['keyword'].upcase)
    @find = @user.search_histories.find_by(asset_id: @asset.id)

    if @find
      @user.search_histories.delete(@find)
    end

    @new_search = @user.search_histories.create(asset_id: @asset.id)
    render json: @new_search
  end

  def destroy
  end
end
