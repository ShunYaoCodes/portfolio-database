class Api::V1::PortfolioAssetsController < ApplicationController
  before_action :requires_login, only: [:index]

  def index
    render json: PortfolioAsset.all
  end

  def show
    @portfolio_asset = User.find(params[:id]).portfolio_assets
    @symbols = []
    @portfolio_asset.each do |history|
      @symbols << {symbol: Asset.all.find{|asset| asset.id == history.asset_id}.symbol, position_type: history.position_type}
    end
    render json: @symbols
  end

  def create
    @user = User.find(1)
    @asset = Asset.find_or_create_by(symbol: params['symbol'].upcase)
    @portfolio_asset = @user.portfolio_assets.find_or_create_by(asset_id: @asset.id)
    render json: @portfolio_asset
  end

  def update
    @user = User.find(params[:id])
    @asset = Asset.find_by(symbol: params['symbol'].upcase)
    @portfolio_asset = @user.portfolio_assets.find_by(asset_id: @asset.id)
    @portfolio_asset[:position_type] = params['position_type']
    @portfolio_asset.save
    #byebug
  end

  def destroy
    @portfolio_asset = User.find(params[:id]).portfolio_assets
    @asset = Asset.find_by(symbol: params['symbol'])
    @symbol = @portfolio_asset.find_by(asset_id: @asset.id)
    @symbol.destroy
  end
end
