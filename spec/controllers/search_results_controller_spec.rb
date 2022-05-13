require 'rails_helper'

RSpec.describe SearchResultsController, type: :controller do
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

    context "when there are officer results" do
      let!(:officer) { create :officer, :reindex, first_name: 'Bob' }

      it "returns the results" do
        get :index, params: { q: 'bob' }
        expect(assigns(:search_results).to_a).to eq([officer])
      end
    end

    context "when there are incident results" do
      let!(:incident) { create :incident, :reindex, heading: 'The fruit saga' }

      it "returns the results" do
        get :index, params: { q: 'fruit' }
        expect(assigns(:search_results).to_a).to eq([incident])
      end
    end

    context "when there are document results" do
      let!(:document) { create :document, :reindex, name: 'Frooty Tooty' }

      it "returns the results" do
        get :index, params: { q: 'frooty' }
        expect(assigns(:search_results).to_a).to eq([document])
      end
    end
  end
end
