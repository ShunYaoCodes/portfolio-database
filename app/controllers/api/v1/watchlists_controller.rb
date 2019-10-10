class Api::V1::WatchlistsController < ApplicationController
  before_action :requires_login, only: [:create]

  def index
    if (params[:user_id])
      @watchlist = User.find(params[:user_id]).watchlists
      @symbols = []

      @watchlist.each do |history|
        @symbols << Asset.all.find{|asset| asset.id == history.asset_id}.symbol
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
    @user = User.find(params[:userId])
    @asset = Asset.find_or_create_by(symbol: params['symbol'].upcase)
    @new_search = @user.watchlists.find_or_create_by(asset_id: @asset.id)

    render json: @new_search
  end

  def update
  end

  def destroy
    @watchlist = User.find(params[:id]).watchlists
    @asset = Asset.find_by(symbol: params['symbol'])
    @symbol = @watchlist.find_by(asset_id: @asset.id)
    @symbol.destroy
  end
end
