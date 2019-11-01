class Api::V1::PortfolioAssetsController < ApplicationController
  before_action :requires_login

  def index
    if (params[:user_id])
      @user = User.find(params[:user_id])
      @portfolio_assets = @user.portfolio_assets
      @positions = []

      @portfolio_assets.each do |portfolio_asset|
        @positions << [
          [:id, portfolio_asset.id], 
          [:symbol, Asset.all.find{|asset| asset.id == portfolio_asset.asset_id}.symbol], 
          [:position_type, portfolio_asset.position_type]
        ].to_h
      end

      render json: {
        positions: @positions,
        investment_amount: @user.investment_amount
      }
    else
      @portfolio_assets = PortfolioAsset.all
      render json: @portfolio_assets
    end
  end

  def show
    @portfolio_assets = User.find(params[:id]).portfolio_assets
    @positions = []
    @portfolio_assets.each do |history|
      @positions << {symbol: Asset.all.find{|asset| asset.id == history.asset_id}.symbol, position_type: history.position_type}
    end
    render json: @positions
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
    @portfolio_asset = PortfolioAsset.find(params[:id])
    @portfolio_asset[:position_type] = params[:position_type]
    @portfolio_asset.save
  end

  def destroy
    @position = PortfolioAsset.find(params[:id])
    @position.destroy

    render json: {}
  end
end
