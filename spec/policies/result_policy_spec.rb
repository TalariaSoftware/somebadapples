require 'rails_helper'

RSpec.describe ResultPolicy, :search do
  let(:resolved_scope) do
    ResultPolicy::Scope.new(user, results).resolve
  end
  let(:user) { nil }

  let(:results) do
    Searchkick.search('*', models: [Incident, Document])
  end

  let!(:incident) { create :incident, :reindex }
  let!(:document) { create :document, :reindex }

  describe 'scope' do
    it "includes the incident" do
      expect(resolved_scope).to include(incident)
    end

    it "includes the document" do
      expect(resolved_scope).to include(document)
    end
  end
end
