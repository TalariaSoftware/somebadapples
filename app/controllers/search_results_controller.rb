class SearchResultsController < ApplicationController
  include Pagy::Backend

  def index
    skip_policy_scope

    search_results = PgSearch.multisearch(params[:q])

    @pagy, @search_results = pagy(search_results, items: 50)
  end
end
