require 'rails_helper'

RSpec.describe ResultPolicy, :search do
  let(:resolved_scope) do
    ResultPolicy::Scope.new(user, results).resolve
  end
  let(:user) { nil }

  let(:results) do
    Searchkick.search('*', models: [Officer, Incident, ExternalDocument])
  end

  let!(:officer) { create :officer, :reindex }
  let!(:incident) { create :incident, :reindex }
  let!(:document) { create :external_document, :reindex }

  describe 'scope' do
    it "includes the officer" do
      expect(resolved_scope).to include(officer)
    end

    it "includes the incident" do
      expect(resolved_scope).to include(incident)
    end

    it "includes the document" do
      expect(resolved_scope).to include(document)
    end
  end
end
