class SearchResultsController < ApplicationController
  include Pagy::Backend

  def index
    skip_policy_scope

    collection = Searchkick.pagy_search(
      params[:q],
      models: [Agency, Document, Incident, Officer],
    )

    @pagy, @search_results = pagy_searchkick(collection, items: 50)
  end
end
