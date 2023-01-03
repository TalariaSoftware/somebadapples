require 'rails_helper'

RSpec.describe IncidentsController do
  before { sign_in user }

  let(:user) { create :user }

  describe '#index' do
    it "returns http success" do
      get :index
      expect(response).to be_ok
    end

    context "when there are incidents" do
      let(:incident) { create :incident }

      it "returns the incidents" do
        get :index
        expect(assigns(:incidents)).to eq([incident])
      end
    end
  end

  describe '#new' do
    it "returns http success" do
      get :new
      expect(response).to be_ok
    end

    describe 'incident' do
      subject(:incident) do
        get :new
        assigns(:incident)
      end

      it { is_expected.to be_an(Incident) }
      it { is_expected.not_to be_persisted }
    end
  end

  describe '#create' do
    let(:params) do
      {
        incident: {
          heading: "Violence",
          description: "Shot someone",
          datetime: "2021-12-10 21:30",
        },
      }
    end

    it "redirects to the incident" do
      post :create, params: params
      expect(response).to redirect_to(Incident.order(:created_at).last)
    end

    it "creates an incident" do
      expect {
        post :create, params: params
      }.to change(Incident, :count).by(1)
    end

    describe "new incident" do
      subject(:incident) do
        post :create, params: params
        Incident.all.order(:created_at).last
      end

      specify { expect(incident.heading).to eq("Violence") }
      specify { expect(incident.description).to eq("Shot someone") }

      specify do
        expect(incident.datetime).to eq(DateTime.parse("2021-12-10 21:30"))
      end
    end
  end

  describe '#show' do
    let(:incident) { create :incident }
    let(:params) { { id: incident.id } }

    it "returns http success" do
      get :show, params: params
      expect(response).to be_ok
    end

    it "assigns the incident" do
      get :show, params: params
      expect(assigns(:incident)).to eq(incident)
    end
  end

  describe '#edit' do
    let(:incident) { create :incident }
    let(:params) { { id: incident.id } }

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the incident" do
      get :edit, params: params
      expect(assigns(:incident)).to eq(incident)
    end
  end

  describe '#update' do
    let(:incident) { create :incident }
    let(:params) do
      {
        id: incident.id,
        incident: {
          heading: "Assault",
          description: "Punched guy",
          datetime: "2021-12-10 22:30",
        },
      }
    end

    it "updates the heading" do
      expect {
        put :update, params: params
        incident.reload
      }.to change(incident, :heading).to("Assault")
    end

    it "updates the description" do
      expect {
        put :update, params: params
        incident.reload
      }.to change(incident, :description).to("Punched guy")
    end

    it "updates the datetime" do
      expect {
        put :update, params: params
        incident.reload
      }.to change(incident, :datetime).to(DateTime.parse("2021-12-10 22:30"))
    end
  end

  describe '#delete' do
    let(:incident) { create :incident }
    let(:params) { { id: incident.id } }

    it "redirects to the incident list" do
      delete :destroy, params: params
      expect(response).to redirect_to(incidents_path)
    end

    it "deletes the incident" do
      expect {
        delete :destroy, params: params
      }.to change { Incident.exists?(incident.id) }.to(false)
    end
  end
end
