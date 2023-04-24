require 'rails_helper'

RSpec.describe LapdHeadshotsController do
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

    context "when there is an LAPD headshot" do
      let!(:headshot) { create :lapd_headshot }

      it "assigns the headshot" do
        get :index, params: params
        expect(assigns(:lapd_headshots)).to eq([headshot])
      end
    end

    context "when there are multiple POST records" do
      let!(:headshot_b) do
        create :lapd_headshot, file_name: "BRAVO, BOB - 123456.jpg"
      end
      let!(:headshot_a) do
        create :lapd_headshot, file_name: "ALPHA, ALICE - # 123457.jpg"
      end

      it "puts the records in alphabetical order by file name" do
        get :index, params: params
        expect(assigns(:lapd_headshots)).to eq([headshot_a, headshot_b])
      end
    end
  end

  describe '#show' do
    let(:params) { {id: headshot.id} }

    let(:headshot) { create :lapd_headshot }

    it "returns http success" do
      get :show, params: params
      expect(response).to be_ok
    end

    it "assigns the headshot" do
      get :show, params: params
      expect(assigns(:lapd_headshot)).to eq(headshot)
    end
  end
end
