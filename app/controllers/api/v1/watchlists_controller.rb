class Api::V1::WatchlistsController < ApplicationController
  before_action :requires_login

  def index
    if (params[:user_id])
      @watchlist = User.find(params[:user_id]).watchlists
      @symbols = []

      @watchlist.each do |history|
        @symbols << [[:id, history.id], [:symbol, Asset.all.find{|asset| asset.id == history.asset_id}.symbol]].to_h
      end

      render json: @symbols
    else
      @watchlists = Watchlist.all
      render json: @watchlists
    end
  end

  def show
    @watchlist = User.find(params[:id]).watchlists
    @symbols = []
    @watchlist.each do |history|
      @symbols << Asset.all.find{|asset| asset.id == history.asset_id}.symbol
    end
    render json: @symbols
  end

  def create
    @user = User.find(params[:user_id])
    @asset = Asset.find_or_create_by(symbol: params[:symbol].upcase)
    @new_search = @user.watchlists.find_or_create_by(asset_id: @asset.id)

    render json: {
      id: @new_search.id, 
      symbol: params[:symbol].upcase
    }
  end

  def update
  end

  def destroy
    # @watchlist = User.find(params[:user_id]).watchlists
    # @asset = Asset.find_by(symbol: params[:id])
    @symbol = Watchlist.find(params[:id])
    @symbol.destroy

    render json: {}
  end
end
