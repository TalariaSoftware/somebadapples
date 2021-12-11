require 'rails_helper'

RSpec.describe OfficersController, type: :controller do
  let(:user) { User.create! email: 'user@example.com', password: 'password' }

  describe '#index' do
    it "returns http success" do
      get :index
      expect(response).to be_ok
    end

    context "when there are officers" do
      let!(:officer) { Officer.create! }

      it "assigns the officers" do
        get :index
        expect(assigns(:officers)).to eq([officer])
      end
    end
  end

  describe '#new' do
    before { sign_in user }

    it "returns http success" do
      get :new
      expect(response).to be_ok
    end

    describe 'officer' do
      subject(:officer) do
        get :new
        assigns(:officer)
      end

      it { is_expected.to be_an(Officer) }
      it { is_expected.not_to be_persisted }
    end
  end

  describe '#create' do
    before { sign_in user }

    let(:params) do
      {
        officer: {
          first_name: "Javert",
          last_name: "Valjean",
          badge_number: "pi",
          serial_number: "googol",
        },
      }
    end

    it "redirects to the new officer" do
      post :create, params: params
      expect(response).to redirect_to(Officer.all.last)
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

      specify { expect(officer.first_name).to eq("Javert") }
      specify { expect(officer.last_name).to eq("Valjean") }
      specify { expect(officer.badge_number).to eq("pi") }
      specify { expect(officer.serial_number).to eq("googol") }
    end
  end

  describe '#show' do
    let(:officer) { Officer.create! }
    let(:params) { { id: officer.id } }

    it "returns http success" do
      get :show, params: params
      expect(response).to be_ok
    end

    it "assigns the officer" do
      get :show, params: params
      expect(assigns(:officer)).to eq(officer)
    end
  end

  describe '#edit' do
    before { sign_in user }

    let(:officer) { Officer.create! }
    let(:params) { { id: officer.id } }

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the officer" do
      get :edit, params: params
      expect(assigns(:officer)).to eq(officer)
    end
  end

  describe '#update' do
    before { sign_in user }

    let(:officer) { Officer.create! }
    let(:params) do
      {
        id: officer.id,
        officer: {
          first_name: "Allan",
          last_name: "Pinkerton",
          badge_number: "7",
          serial_number: "13",
        },
      }
    end

    it "redirects to the officer" do
      put :update, params: params
      expect(response).to redirect_to(officer)
    end

    it "updates the first name" do
      expect {
        put :update, params: params
        officer.reload
      }.to change(officer, :first_name).to("Allan")
    end

    it "updates the last name" do
      expect {
        put :update, params: params
        officer.reload
      }.to change(officer, :last_name).to("Pinkerton")
    end

    it "updates the badge number" do
      expect {
        put :update, params: params
        officer.reload
      }.to change(officer, :badge_number).to("7")
    end

    it "updates the serial number" do
      expect {
        put :update, params: params
        officer.reload
      }.to change(officer, :serial_number).to("13")
    end
  end

  describe '#delete' do
    before { sign_in user }

    let(:officer) { Officer.create! }
    let(:params) { { id: officer.id } }

    it "redirects to the officer list" do
      delete :destroy, params: params
      expect(response).to redirect_to(officers_path)
    end

    it "deletes the officer" do
      expect {
        delete :destroy, params: params
      }.to change { Officer.exists?(officer.id) }.to(false)
    end
  end
end
