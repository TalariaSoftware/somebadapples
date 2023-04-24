class SearchResultsController < ApplicationController
  include Pagy::Backend

  SEARCH_MODELS = [
    Agency, Document, Incident, Officer, PostRecord, LapdHeadshot
  ].freeze

  def index
    skip_policy_scope

    search_results = Searchkick.pagy_search(
      params[:q],
      models: SEARCH_MODELS,
    )

    @pagy, @search_results = pagy_searchkick(search_results, items: 50)
  end
end
