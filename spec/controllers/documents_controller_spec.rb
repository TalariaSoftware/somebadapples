require 'rails_helper'

RSpec.describe DocumentsController do
  before { sign_in user }

  let(:user) { create :user }
  let(:incident) { create :incident }

  describe '#new' do
    let(:params) { { document: { incident_id: incident.id } } }

    it "returns http success" do
      get :new, params: params
      expect(response).to be_ok
    end

    describe 'document' do
      subject(:document) do
        get :new, params: params
        assigns(:document)
      end

      it { is_expected.to be_an(Document) }
      it { is_expected.not_to be_persisted }
      specify { expect(document.incident).to eq(incident) }
    end
  end

  describe '#create' do
    let(:params) do
      {
        document: {
          incident_id: incident.id,
          name: "Tweet",
          description: "Incident video",
          url: "https://example.com",
        },
      }
    end

    it "redirects to the incident" do
      post :create, params: params
      expect(response).to redirect_to(incident)
    end

    it "creates an document" do
      expect {
        post :create, params: params
      }.to change(Document, :count).by(1)
    end

    describe "new document" do
      subject(:document) do
        post :create, params: params
        Document.all.order(:created_at).last
      end

      specify { expect(document.incident).to eq(incident) }
      specify { expect(document.name).to eq("Tweet") }
      specify { expect(document.description).to eq("Incident video") }
      specify { expect(document.url).to eq("https://example.com") }
    end
  end

  describe '#edit' do
    let(:document) { create :document }
    let(:params) { { id: document.id } }

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the document" do
      get :edit, params: params
      expect(assigns(:document)).to eq(document)
    end
  end

  describe '#update' do
    let(:document) { create :document }
    let(:params) do
      {
        id: document.id,
        document: {
          name: "Insta",
          description: "Incident photo",
          url: "https://www.example.com",
        },
      }
    end

    it "redirects to the incident" do
      put :update, params: params
      expect(response).to redirect_to(document.incident)
    end

    it "updates the name" do
      expect {
        put :update, params: params
        document.reload
      }.to change(document, :name).to("Insta")
    end

    it "updates the description" do
      expect {
        put :update, params: params
        document.reload
      }.to change(document, :description).to("Incident photo")
    end

    it "updates the url" do
      expect {
        put :update, params: params
        document.reload
      }.to change(document, :url).to("https://www.example.com")
    end
  end

  describe '#delete' do
    let(:document) { create :document }
    let(:params) { { id: document.id } }

    it "redirects to the incident" do
      delete :destroy, params: params
      expect(response).to redirect_to(document.incident)
    end

    it "deletes the document" do
      expect {
        delete :destroy, params: params
      }.to change { Document.exists?(document.id) }.to(false)
    end
  end
end
