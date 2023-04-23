require 'rails_helper'

RSpec.describe SearchResultsController do
  describe '#index', :search do
    it "returns http success" do
      get :index
      expect(response).to be_ok
    end

    context "when there are no results" do
      it "returns an empty set" do
        get :index
        expect(assigns(:search_results)).to be_empty
      end
    end

    context "when there are matching POST record results" do
      before { create :post_record, officer_name: 'PINKERTON, ROBERT' }

      it "returns the results" do
        get :index, params: { q: 'pinkerton' }
        expect(assigns(:search_results).count).to eq(1)
      end
    end
  end
end
