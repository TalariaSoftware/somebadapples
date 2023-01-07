require 'rails_helper'

RSpec.describe AgenciesController do
  before { sign_in user }

  let(:user) { create :user }

  describe '#index' do
    it "returns http success" do
      get :index
      expect(response).to be_ok
    end

    context "when there are agencies" do
      let!(:agency) { create :agency }

      it "assigns the agency" do
        get :index
        expect(assigns(:agencies)).to eq([agency])
      end
    end

    context "when there are multiple agencies" do
      let!(:agency_b) { create :agency, name: "Beta" }
      let!(:agency_a) { create :agency, name: "Alpha" }

      it "puts the agencies in alphabetical order" do
        get :index
        expect(assigns(:agencies)).to eq([agency_a, agency_b])
      end
    end
  end

  describe '#new' do
    it "returns http success" do
      get :new
      expect(response).to be_ok
    end

    it "assigns a new agency" do
      get :new
      expect(assigns(:agency)).not_to be_persisted
    end
  end

  describe '#create' do
    let(:params) do
      {
        agency: {
          name: "Metro Police Department",
          short_name: "MPD",
        },
      }
    end

    it "creates an agency" do
      expect {
        post :create, params: params
      }.to change(Agency, :count).by(1)
    end

    it "redirects to the agency" do
      post :create, params: params
      expect(response).to redirect_to(Agency.last)
    end

    describe "new agency" do
      subject(:agency) do
        post :create, params: params
        Agency.all.order(:created_at).last
      end

      specify { expect(agency.name).to eq("Metro Police Department") }
      specify { expect(agency.short_name).to eq("MPD") }
    end
  end

  describe '#show' do
    let(:agency) { create :agency }
    let(:params) { { id: agency.id } }

    it "returns http success" do
      get :show, params: params
      expect(response).to be_ok
    end

    it "assigns the agency" do
      get :show, params: params
      expect(assigns(:agency)).to eq(agency)
    end
  end

  describe '#edit' do
    let(:agency) { create :agency }
    let(:params) { { id: agency.id } }

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the agency" do
      get :edit, params: params
      expect(assigns(:agency)).to eq(agency)
    end
  end

  describe '#update' do
    let(:agency) { create :agency }
    let(:params) do
      {
        id: agency.id,
        agency: {
          name: "Metro Police",
          short_name: "MPD",
        },
      }
    end

    it "redirects to the agency" do
      put :update, params: params
      expect(response).to redirect_to(agency)
    end

    it "updates the name" do
      expect {
        put :update, params: params
        agency.reload
      }.to change(agency, :name).to("Metro Police")
    end

    it "updates the short name" do
      expect {
        put :update, params: params
        agency.reload
      }.to change(agency, :short_name).to("MPD")
    end
  end

  describe '#delete' do
    let(:agency) { create :agency }
    let(:params) { { id: agency.id } }

    it "redirects to the index page" do
      delete :destroy, params: params
      expect(response).to redirect_to(agencies_path)
    end

    it "deletes the agency" do
      expect {
        delete :destroy, params: params
      }.to change { Agency.exists?(agency.id) }.to(false)
    end
  end
end
