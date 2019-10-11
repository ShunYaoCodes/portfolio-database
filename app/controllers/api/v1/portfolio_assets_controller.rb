class Api::V1::PortfolioAssetsController < ApplicationController
  before_action :requires_login

  def index
    if (params[:user_id])
      @portfolio_assets = User.find(params[:user_id]).portfolio_assets
      @symbols = []

      @portfolio_assets.each do |history|
        @symbols << [[:id, history.id], [:symbol, Asset.all.find{|asset| asset.id == history.asset_id}.symbol]].to_h
      end

      render json: @symbols
    else
      @portfolio_assets = PortfolioAsset.all
      render json: @portfolio_assets
    end
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
    @user = User.find(params[:user_id])
    @asset = Asset.find_or_create_by(symbol: params[:symbol].upcase)
    @portfolio_asset = @user.portfolio_assets.find_or_create_by(asset_id: @asset.id)

    render json: {
      id: @portfolio_asset.id,
      symbol: params[:symbol].upcase
    }
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
    @symbol = PortfolioAsset.find(params[:id])
    @symbol.destroy

    render json: {}
  end
end
