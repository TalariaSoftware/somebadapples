require 'rails_helper'

RSpec.describe Us::Ca::LosAngeles::Police::Roster20220820::EntriesController do
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

    context "when there is a roster entry" do
      let!(:entry) { create :'us/ca/los_angeles/police/roster20220820_entry' }

      it "assigns the entry" do
        get :index, params: params
        expect(assigns(:entries)).to eq([entry])
      end
    end

    context "when there are multiple roster entries" do
      let!(:entry_b) do
        create :'us/ca/los_angeles/police/roster20220820_entry',
          employee_name: "BRAVO, BOB"
      end
      let!(:entry_a) do
        create :'us/ca/los_angeles/police/roster20220820_entry',
          employee_name: "ALPHA, ALICE"
      end

      it "puts the records in alphabetical order by employee name" do
        get :index, params: params
        expect(assigns(:entries)).to eq([entry_a, entry_b])
      end
    end
  end

  describe '#show' do
    let(:params) { { id: entry.serial_no } }

    let(:entry) { create :'us/ca/los_angeles/police/roster20220820_entry' }

    it "returns http success" do
      get :show, params: params
      expect(response).to be_ok
    end

    it "assigns the entry" do
      get :show, params: params
      expect(assigns(:entry)).to eq(entry)
    end
  end
end
