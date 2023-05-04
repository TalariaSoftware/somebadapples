require 'rails_helper'

RSpec.describe Us::Ca::LosAngeles::Police::Headshots20230321::HeadshotsController do # rubocop:disable Layout/LineLength
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

    context "when there is a headshot" do
      let!(:headshot) do
        create :'us/ca/los_angeles/police/headshots20230321_headshot'
      end

      it "assigns the headshot" do
        get :index, params: params
        expect(assigns(:headshots)).to eq([headshot])
      end
    end

    context "when there are multiple headshots" do
      let!(:headshot_b) do
        create :'us/ca/los_angeles/police/headshots20230321_headshot',
          file_name: "BRAVO, BOB - 123456.jpg"
      end
      let!(:headshot_a) do
        create :'us/ca/los_angeles/police/headshots20230321_headshot',
          file_name: "ALPHA, ALICE - # 123457.jpg"
      end

      it "puts the records in alphabetical order by file name" do
        get :index, params: params
        expect(assigns(:headshots)).to eq([headshot_a, headshot_b])
      end
    end
  end

  describe '#show' do
    let(:params) { { id: headshot.slug } }

    let(:headshot) do
      create :'us/ca/los_angeles/police/headshots20230321_headshot'
    end

    it "returns http success" do
      get :show, params: params
      expect(response).to be_ok
    end

    it "assigns the headshot" do
      get :show, params: params
      expect(assigns(:headshot)).to eq(headshot)
    end
  end
end
