require 'rails_helper'

RSpec.describe IncidentRolesController, type: :controller do
  before { sign_in user }

  let(:user) { create :user }

  describe '#new' do
    let(:params) do
      {
        incident_id: incident.id,
      }
    end
    let(:incident) { create :incident }

    it "returns http success" do
      get :new, params: params
      expect(response).to be_ok
    end

    describe 'incident' do
      subject(:incident_role) do
        get :new, params: params
        assigns(:incident_role)
      end

      it { is_expected.to be_an(IncidentRole) }
      it { is_expected.not_to be_persisted }
      specify { expect(incident_role.incident).to eq(incident) }
    end
  end

  describe '#create' do
    let(:params) do
      {
        incident_id: incident.id,
        incident_role: {
          officer_id: officer.id,
          description: "Was at the scene",
        },
      }
    end
    let(:incident) { create :incident }
    let(:officer) { create :officer }

    it "redirects to the incident" do
      post :create, params: params
      expect(response).to redirect_to(incident)
    end

    it "creates an incident role" do
      expect {
        post :create, params: params
      }.to change(IncidentRole, :count).by(1)
    end

    describe "new incident role" do
      subject(:incident_role) do
        post :create, params: params
        IncidentRole.all.order(:created_at).last
      end

      specify { expect(incident_role.officer).to eq(officer) }
      specify { expect(incident_role.incident).to eq(incident) }
      specify { expect(incident_role.description).to eq("Was at the scene") }
    end
  end

  describe '#edit' do
    let(:incident_role) { create :incident_role }
    let(:params) do
      {
        incident_id: incident_role.incident_id,
        id: incident_role.id,
      }
    end

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the incident role" do
      get :edit, params: params
      expect(assigns(:incident_role)).to eq(incident_role)
    end
  end

  describe '#update' do
    let(:incident_role) { create :incident_role }
    let(:params) do
      {
        incident_id: incident_role.incident_id,
        id: incident_role.id,
        incident_role: {
          officer_id: new_officer.id,
          incident_id: new_incident.id,
          description: "New description",
        },
      }
    end
    let(:new_officer) { create :officer }
    let(:new_incident) { create :incident }

    it "redirects to the new incident" do
      put :update, params: params
      expect(response).to redirect_to(new_incident)
    end

    it "updates the officer" do
      expect {
        put :update, params: params
        incident_role.reload
      }.to change(incident_role, :officer).to(new_officer)
    end

    it "updates the incident" do
      expect {
        put :update, params: params
        incident_role.reload
      }.to change(incident_role, :incident).to(new_incident)
    end

    it "updates the description" do
      expect {
        put :update, params: params
        incident_role.reload
      }.to change(incident_role, :description).to("New description")
    end
  end

  describe '#delete' do
    let(:incident_role) { create :incident_role }
    let(:params) do
      {
        incident_id: incident_role.incident_id,
        id: incident_role.id,
      }
    end

    it "redirects to the incident" do
      delete :destroy, params: params
      expect(response).to redirect_to(incident_role.incident)
    end

    it "deletes the incident role" do
      expect {
        delete :destroy, params: params
      }.to change { IncidentRole.exists?(incident_role.id) }.to(false)
    end
  end
end
