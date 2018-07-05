class Api::V1::SearchHistoriesController < ApplicationController
  def index
    @all_histories = SearchHistory.all
    render json: @all_histories
  end

  def show
    @search_histories = User.find(params[:id])
    render json: @search_histories
  end

  def create
    byebug
    @new_search = SearchHistory.create(params['keyword'])
    render json: @new_search
  end

  def delete
  end
end
