require 'rails_helper'

RSpec.describe OfficersController do
  let(:user) { create :user }

  describe '#index' do
    let(:params) { { agency_id: agency.id } }

    let(:agency) { create :agency }

    it "returns http success" do
      get :index, params: params
      expect(response).to be_ok
    end

    it "paginates the list" do
      get :index, params: params
      expect(assigns(:pagy)).to be_a(Pagy)
    end

    context "when there is an officer" do
      let!(:officer) { Officer.create! }

      context "when the officer is in a different agency" do
        before do
          create :position, officer: officer, agency: other_agency
        end

        let(:other_agency) { create :agency }

        it "assigns no officers" do
          get :index, params: params
          expect(assigns(:officers)).to be_empty
        end
      end

      context "when the officer is in the agency" do
        before do
          create :position, officer: officer, agency: agency
        end

        it "assigns the officers" do
          get :index, params: params
          expect(assigns(:officers)).to eq([officer])
        end
      end
    end

    context "when there are multiple officers" do
      let(:officer_b) { create :officer, last_name: "Beta" }
      let(:officer_a) { create :officer, last_name: "Alpha" }

      before do
        create :position, officer: officer_b, agency: agency
        create :position, officer: officer_a, agency: agency
      end

      it "puts the officers in alphabetical order" do
        get :index, params: params
        expect(assigns(:officers)).to eq([officer_a, officer_b])
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
          middle_name: "Jon",
          last_name: "Valjean",
          suffix: "Jr.",
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
      specify { expect(officer.middle_name).to eq("Jon") }
      specify { expect(officer.last_name).to eq("Valjean") }
      specify { expect(officer.suffix).to eq("Jr.") }
    end
  end

  describe '#show' do
    let(:officer) { create :officer }
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

    let(:officer) { create :officer }
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

    let(:officer) { create :officer }
    let(:params) do
      {
        id: officer.id,
        officer: {
          first_name: "Allan",
          middle_name: "Jay",
          last_name: "Pinkerton",
          suffix: "Sr.",
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

    it "updates the middle name" do
      expect {
        put :update, params: params
        officer.reload
      }.to change(officer, :middle_name).to("Jay")
    end

    it "updates the last name" do
      expect {
        put :update, params: params
        officer.reload
      }.to change(officer, :last_name).to("Pinkerton")
    end

    it "updates the suffix" do
      expect {
        put :update, params: params
        officer.reload
      }.to change(officer, :suffix).to("Sr.")
    end
  end

  describe '#delete' do
    before { sign_in user }

    let(:officer) { create :officer }
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
