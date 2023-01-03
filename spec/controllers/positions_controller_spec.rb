require 'rails_helper'

RSpec.describe PositionsController do
  before { sign_in user }

  let(:user) { create :user }

  describe '#new' do
    let(:params) do
      {
        officer_id: officer.id,
      }
    end
    let(:officer) { create :officer }

    it "returns http success" do
      get :new, params: params
      expect(response).to be_ok
    end

    describe 'position' do
      subject(:position) do
        get :new, params: params
        assigns(:position)
      end

      it { is_expected.to be_a(Position) }
      it { is_expected.not_to be_persisted }
      specify { expect(position.officer).to eq(officer) }
    end
  end

  describe '#create' do
    let(:params) do
      {
        officer_id: officer.id,
        position: {
          agency_id: agency.id,
          badge_number: '123',
          serial_number: '789',
        },
      }
    end
    let(:officer) { create :officer }
    let(:position) { create :position }
    let(:agency) { create :agency }

    it "redirects to the officer" do
      post :create, params: params
      expect(response).to redirect_to(officer)
    end

    it "creates a position" do
      expect {
        post :create, params: params
      }.to change(Position, :count).by(1)
    end

    describe "new position" do
      subject(:position) do
        post :create, params: params
        Position.all.order(:created_at).last
      end

      specify { expect(position.officer).to eq(officer) }
      specify { expect(position.agency).to eq(agency) }
      specify { expect(position.badge_number).to eq('123') }
      specify { expect(position.serial_number).to eq('789') }
    end
  end

  describe '#edit' do
    let(:position) { create :position }
    let(:agency) { create :agency }
    let(:params) do
      {
        officer_id: position.officer_id,
        id: position.id,
      }
    end

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the position" do
      get :edit, params: params
      expect(assigns(:position)).to eq(position)
    end
  end

  describe '#update' do
    let(:position) { create :position }
    let(:agency) { create :agency }
    let(:params) do
      {
        officer_id: position.officer_id,
        id: position.id,
        position: {
          agency_id: agency.id,
          badge_number: '456',
          serial_number: '654',
        },
      }
    end

    it "redirects to the officer" do
      put :update, params: params
      expect(response).to redirect_to(position.officer)
    end

    it "updates the position" do
      expect {
        put :update, params: params
        position.reload
      }.to change(position, :agency).to(agency)
    end

    it "updates the badge number" do
      expect {
        put :update, params: params
        position.reload
      }.to change(position, :badge_number).to('456')
    end

    it "updates the serial number" do
      expect {
        put :update, params: params
        position.reload
      }.to change(position, :serial_number).to('654')
    end
  end

  describe '#delete' do
    let(:position) { create :position }
    let(:params) do
      {
        officer_id: position.officer_id,
        id: position.id,
      }
    end

    it "redirects to the officer" do
      delete :destroy, params: params
      expect(response).to redirect_to(position.officer)
    end

    it "deletes the position" do
      expect {
        delete :destroy, params: params
      }.to change { Position.exists?(position.id) }.to(false)
    end
  end
end
