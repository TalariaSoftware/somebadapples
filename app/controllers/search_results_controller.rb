class SearchResultsController < ApplicationController
  def index
    @search_results = policy_scope Officer.search(params[:q])
  end
end
