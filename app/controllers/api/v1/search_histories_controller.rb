class Api::V1::SearchHistoriesController < ApplicationController
  before_action :requires_login

  def index
    if (params[:user_id])
      @search_history = User.find(params[:user_id]).search_histories
      @symbols = []

      @search_history.each do |history|
        @symbols << [[:id, history.id], [:symbol, Asset.all.find{|asset| asset.id == history.asset_id}.symbol]].to_h
      end

      render json: @symbols.reverse # display from latest to oldest
    else
      @search_histories = SearchHistory.all
      render json: @search_histories
    end
  end

  def show
    # @search_histories = User.find(params[:id]).search_histories
    # @symbols = []
    # @search_histories.each do |history|
    #   @symbols << Asset.all.find{|asset| asset.id == history.asset_id}.symbol
    # end
    # render json: @symbols.reverse # display from latest to oldest
  end

  def create
    @user = User.find(params[:user_id])
    @asset = Asset.find_or_create_by(symbol: params[:symbol].upcase)
    @find = @user.search_histories.find_or_create_by(asset_id: @asset.id)

    if @find
      @user.search_histories.delete(@find)
    end

    @new_search = @user.search_histories.create(asset_id: @asset.id)

    render json: {
      id: @new_search.id, 
      symbol: params[:symbol].upcase
    }
    # render @user.search_histories
  end

  def destroy
  end
end
