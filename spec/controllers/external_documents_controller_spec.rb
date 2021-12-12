require 'rails_helper'

RSpec.describe ExternalDocumentsController, type: :controller do
  before { sign_in user }

  let(:user) { create :user }
  let(:incident) { create :incident }

  describe '#new' do
    let(:params) { { external_document: { incident_id: incident.id } } }

    it "returns http success" do
      get :new, params: params
      expect(response).to be_ok
    end

    describe 'external document' do
      subject(:external_document) do
        get :new, params: params
        assigns(:external_document)
      end

      it { is_expected.to be_an(ExternalDocument) }
      it { is_expected.not_to be_persisted }
      specify { expect(external_document.incident).to eq(incident) }
    end
  end

  describe '#create' do
    let(:params) do
      {
        external_document: {
          incident_id: incident.id,
          name: "Tweet",
          description: "Incident video",
          url: "https://example.com",
        },
      }
    end

    it "redirects to the officer" do
      post :create, params: params
      expect(response).to redirect_to(incident.officer)
    end

    it "creates an external document" do
      expect {
        post :create, params: params
      }.to change(ExternalDocument, :count).by(1)
    end

    describe "new external document" do
      subject(:external_document) do
        post :create, params: params
        ExternalDocument.all.order(:created_at).last
      end

      specify { expect(external_document.incident).to eq(incident) }
      specify { expect(external_document.name).to eq("Tweet") }
      specify { expect(external_document.description).to eq("Incident video") }
      specify { expect(external_document.url).to eq("https://example.com") }
    end
  end

  describe '#edit' do
    let(:external_document) { create :external_document }
    let(:params) { { id: external_document.id } }

    it "returns http success" do
      get :edit, params: params
      expect(response).to be_ok
    end

    it "assigns the external document" do
      get :edit, params: params
      expect(assigns(:external_document)).to eq(external_document)
    end
  end

  describe '#update' do
    let(:external_document) { create :external_document }
    let(:params) do
      {
        id: external_document.id,
        external_document: {
          name: "Insta",
          description: "Incident photo",
          url: "https://www.example.com",
        },
      }
    end

    it "redirects to the officer" do
      put :update, params: params
      expect(response).to redirect_to(external_document.incident.officer)
    end

    it "updates the name" do
      expect {
        put :update, params: params
        external_document.reload
      }.to change(external_document, :name).to("Insta")
    end

    it "updates the description" do
      expect {
        put :update, params: params
        external_document.reload
      }.to change(external_document, :description).to("Incident photo")
    end

    it "updates the url" do
      expect {
        put :update, params: params
        external_document.reload
      }.to change(external_document, :url).to("https://www.example.com")
    end
  end

  describe '#delete' do
    let(:external_document) { create :external_document }
    let(:params) { { id: external_document.id } }

    it "redirects to the officer" do
      delete :destroy, params: params
      expect(response).to redirect_to(external_document.incident.officer)
    end

    it "deletes the external document" do
      expect {
        delete :destroy, params: params
      }.to change { ExternalDocument.exists?(external_document.id) }.to(false)
    end
  end
end
