class SearchResultsController < ApplicationController
  include Pagy::Backend

  SEARCH_MODELS = [
    Agency,
    Document,
    Incident,
    Officer,
    PostRecord,
    Us::Ca::LosAngeles::Police::Headshots20230321::Headshot,
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
