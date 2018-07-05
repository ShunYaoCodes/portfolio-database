class Api::V1::SearchHistoriesController < ApplicationController
  def index
    @search_histories = SearchHistory.all
    render json: @earch_histories
  end

  def show
  end

  def create
    byebug
    @new_search = SearchHistory.create(params['keyword'])
    render json: @new_search
  end

  def delete
  end
end
