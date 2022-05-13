class SearchResultsController < ApplicationController
  def index
    @search_results = policy_scope Searchkick.search(
      params[:q],
      models: [Officer, Incident, Document],
    )
  end
end
