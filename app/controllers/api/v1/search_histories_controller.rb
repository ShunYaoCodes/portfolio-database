class Api::V1::SearchHistoriesController < ApplicationController
  def index
    @all_histories = SearchHistory.all
    render json: @all_histories
  end

  def show
    @search_histories = User.find(params[:id]).search_histories
    @symbols = []
    @search_histories.each do |history|
      @symbols << Asset.all.find{|asset| asset.id == history.asset_id}.symbol
    end
    render json: @symbols
  end

  def create
    @user = User.find(1)
    @asset = Asset.find_or_create_by(symbol: params['keyword'].upcase)
    @new_search = @user.search_histories.find_or_create_by(asset_id: @asset.id)
    render json: @new_search
  end

  def destroy
  end
end
