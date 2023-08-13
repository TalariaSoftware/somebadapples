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

    context "when there are post record results" do
      before do
        create :post_record, :reindex, officer_name: 'PINKERTON, BOB'
      end

      it "returns the results" do
        get :index, params: { q: 'bob' }
        expect(assigns(:search_results).first.officer_name)
          .to eq('PINKERTON, BOB')
      end
    end

    context "when there are LAPD headshot results" do
      before do
        create :'us/ca/los_angeles/police/headshots20230321_headshot', :reindex,
          file_name: 'PINKERTON, BOB - 12345.jpg'
      end

      it "returns the results" do
        get :index, params: { q: 'bob' }
        expect(assigns(:search_results).first.file_name)
          .to eq('PINKERTON, BOB - 12345.jpg')
      end
    end

    context "when there are incident results" do
      before do
        create :incident, :reindex, heading: 'The fruit saga'
      end

      it "returns the results" do
        get :index, params: { q: 'fruit' }
        expect(assigns(:search_results).first.heading).to eq('The fruit saga')
      end
    end

    context "when there are document results" do
      before do
        create :document, :reindex, name: 'Frooty Tooty'
      end

      it "returns the results" do
        get :index, params: { q: 'frooty' }
        expect(assigns(:search_results).first.name).to eq('Frooty Tooty')
      end
    end
  end
end
