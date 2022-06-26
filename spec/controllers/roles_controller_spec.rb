require 'rails_helper'

RSpec.describe RolesController, type: :controller do
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
      subject(:role) do
        get :new, params: params
        assigns(:role)
      end

      it { is_expected.to be_an(Role) }
      it { is_expected.not_to be_persisted }
      specify { expect(role.incident).to eq(incident) }
      specify { expect(role.officer).not_to be_persisted }
    end
  end

  describe '#create' do
    let(:params) do
      {
        incident_id: incident.id,
        role: {
          officer_id: officer.id,
          description: "Was at the scene",
          officer_attributes: {
            first_name: "",
            middle_name: "",
            last_name: "",
            suffix: "",
          },
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
      }.to change(Role, :count).by(1)
    end

    describe "new incident role" do
      subject(:role) do
        post :create, params: params
        Role.all.order(:created_at).last
      end

      specify { expect(role.officer).to eq(officer) }
      specify { expect(role.incident).to eq(incident) }
      specify { expect(role.description).to eq("Was at the scene") }
    end

    context "with a new officer" do
      let(:params) do
        {
          incident_id: incident.id,
          role: {
            officer_id: 'new_officer',
            description: "Was at the scene",
            officer_attributes: {
              first_name: "Joe",
              middle_name: "Not",
              last_name: "Kool",
              suffix: "Sr.",
            },
          },
        }
      end

      it "creates an incident role" do
        expect {
          post :create, params: params
        }.to change(Role, :count).by(1)
      end

      it "creates an officer" do
        expect {
          post :create, params: params
        }.to change(Officer, :count).by(1)
      end

      describe "new officer" do
        subject(:officer) do
          post :create, params: params
          Officer.all.order(:created_at).last
        end

        specify { expect(officer.first_name).to eq("Joe") }
        specify { expect(officer.middle_name).to eq("Not") }
        specify { expect(officer.last_name).to eq("Kool") }
        specify { expect(officer.suffix).to eq("Sr.") }
      end
    end
  end

  describe '#edit' do
    let(:role) { create :role }
    let(:params) do
      {
        incident_id: role.incident_id,
        id: role.id,
      }
    end

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the role" do
      get :edit, params: params
      expect(assigns(:role)).to eq(role)
    end
  end

  describe '#update' do
    let(:role) { create :role }
    let(:params) do
      {
        incident_id: role.incident_id,
        id: role.id,
        role: {
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
        role.reload
      }.to change(role, :officer).to(new_officer)
    end

    it "updates the incident" do
      expect {
        put :update, params: params
        role.reload
      }.to change(role, :incident).to(new_incident)
    end

    it "updates the description" do
      expect {
        put :update, params: params
        role.reload
      }.to change(role, :description).to("New description")
    end
  end

  describe '#delete' do
    let(:role) { create :role }
    let(:params) do
      {
        incident_id: role.incident_id,
        id: role.id,
      }
    end

    it "redirects to the incident" do
      delete :destroy, params: params
      expect(response).to redirect_to(role.incident)
    end

    it "deletes the role" do
      expect {
        delete :destroy, params: params
      }.to change { Role.exists?(role.id) }.to(false)
    end
  end
end
