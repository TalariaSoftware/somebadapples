require 'rails_helper'

RSpec.describe IncidentsController, type: :controller do
  before { sign_in user }

  let(:user) { create :user }
  let(:officer) { create :officer }

  describe '#new' do
    let(:params) { { incident: { officer_id: officer.id } } }

    it "returns http success" do
      get :new, params: params
      expect(response).to be_ok
    end

    describe 'incident' do
      subject(:incident) do
        get :new, params: params
        assigns(:incident)
      end

      it { is_expected.to be_an(Incident) }
      it { is_expected.not_to be_persisted }
      specify { expect(incident.officer).to eq(officer) }
    end
  end

  describe '#create' do
    let(:params) do
      {
        incident: {
          officer_id: officer.id,
          description: "Shot someone",
          datetime: "2021-12-10 21:30",
        },
      }
    end

    it "redirects to the officer" do
      post :create, params: params
      expect(response).to redirect_to(officer)
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

      specify { expect(incident.officer).to eq(officer) }
      specify { expect(incident.description).to eq("Shot someone") }

      specify do
        expect(incident.datetime).to eq(DateTime.parse("2021-12-10 21:30"))
      end
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
    let(:officer) { create :officer }
    let(:params) do
      {
        id: incident.id,
        incident: {
          officer_id: officer.id,
          description: "Punched guy",
          datetime: "2021-12-10 22:30",
        },
      }
    end

    it "redirects to the officer" do
      put :update, params: params
      expect(response).to redirect_to(officer)
    end

    it "updates the officer" do
      expect {
        put :update, params: params
        incident.reload
      }.to change(incident, :officer).to(officer)
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
    let(:incident) { create :incident, officer: officer }
    let(:officer) { create :officer }
    let(:params) { { id: incident.id } }

    it "redirects to the officer" do
      delete :destroy, params: params
      expect(response).to redirect_to(officer)
    end

    it "deletes the incident" do
      expect {
        delete :destroy, params: params
      }.to change { Incident.exists?(incident.id) }.to(false)
    end
  end
end
