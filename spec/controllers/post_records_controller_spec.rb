require 'rails_helper'

RSpec.describe PostRecordsController do
  describe '#index' do
    let(:params) { {} }

    it "returns http success" do
      get :index, params: params
      expect(response).to be_ok
    end

    it "paginates the list" do
      get :index, params: params
      expect(assigns(:pagy)).to be_a(Pagy)
    end

    context "when there is a POST record" do
      let!(:post_record) { create :post_record }

      it "assigns the record" do
        get :index, params: params
        expect(assigns(:post_records)).to eq([post_record])
      end
    end

    context "when there are multiple POST records" do
      let!(:record_b) { create :post_record, officer_name: "BRAVO, BOB" }
      let!(:record_a) { create :post_record, officer_name: "ALPHA, ALICE" }

      it "puts the records in alphabetical order by name" do
        get :index, params: params
        expect(assigns(:post_records)).to eq([record_a, record_b])
      end
    end
  end
end
