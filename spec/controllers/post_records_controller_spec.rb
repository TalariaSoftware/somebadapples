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

    context "when a POST ID is given" do
      let(:params) { { post_id: 'A12-B34' } }

      it "returns http success" do
        get :index, params: params
        expect(response).to be_ok
      end

      context "when there is a matching POST record" do
        before { create :post_record, post_id: 'A12-B34' }

        it "assigns the record" do
          get :index, params: params
          expect(assigns(:post_records).first.post_id).to eq('A12-B34')
        end
      end

      context "when there is a non-matching POST record" do
        before { create :post_record, post_id: 'Z98-Y76' }

        it "does not assigns the record" do
          get :index, params: params
          expect(assigns(:post_records)).to be_empty
        end
      end

      context "when the POST ID has lowercase letters" do
        let(:params) { { post_id: 'a12-b34' } }

        it "redirects with an uppercase POST ID" do
          get :index, params: params
          expect(response).to redirect_to('/post_records/A12-B34')
        end
      end
    end
  end
end
