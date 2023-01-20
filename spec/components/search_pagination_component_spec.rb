require 'rails_helper'

RSpec.describe SearchPaginationComponent, type: :component do
  include Rails.application.routes.url_helpers

  subject(:component) { described_class.new pagy: pagy, query: query }

  let(:pagy) { instance_double(Pagy, prev: :previous_page, next: :next_page) }
  let(:query) { "jones" }

  def render_component
    render_inline(component)
  end

  describe "#previous_page" do
    subject { component.previous_page }

    it { is_expected.to be_a(SearchPaginationComponent::Previous) }
    its(:pagy) { is_expected.to eq(pagy) }
    its(:query) { is_expected.to eq(query) }
  end

  describe "#next_page" do
    subject { component.next_page }

    it { is_expected.to be_a(SearchPaginationComponent::Next) }
    its(:pagy) { is_expected.to eq(pagy) }
    its(:query) { is_expected.to eq(query) }
  end

  describe SearchPaginationComponent::Previous do
    let(:component) do
      described_class.new(pagy: pagy, query: query)
    end

    describe "#url" do
      subject { component.url }

      before { render_component }

      it { is_expected.to eq(search_path(q: "jones", page: :previous_page)) }
    end

    describe "#render?" do
      subject { component.render? }

      context "when there is a previous page" do
        let(:pagy) { instance_double(Pagy, prev: 4) }

        it { is_expected.to be_truthy }
      end

      context "when there is no previous page" do
        let(:pagy) { instance_double(Pagy, prev: nil) }

        it { is_expected.to be_falsy }
      end
    end
  end

  describe SearchPaginationComponent::Next do
    let(:component) do
      described_class.new(pagy: pagy, query: query)
    end

    describe "#url" do
      subject { component.url }

      before { render_component }

      it { is_expected.to eq(search_path(q: "jones", page: :next_page)) }
    end

    describe "#render?" do
      subject { component.render? }

      context "when there is a next page" do
        let(:pagy) { instance_double(Pagy, next: 4) }

        it { is_expected.to be_truthy }
      end

      context "when there is no next page" do
        let(:pagy) { instance_double(Pagy, next: nil) }

        it { is_expected.to be_falsy }
      end
    end
  end

  describe SearchPaginationComponent::Item do
    subject(:component) do
      described_class.new(item: item, query: query)
    end

    let(:item) { 10 }

    describe "rendered content" do
      before { render_component }

      context "when the item is a page number" do
        let(:item) { 17 }

        it "includes the page number" do
          expect(page).to have_content("17")
        end

        it "is not styled as the current page" do
          expect(page).not_to have_css('.usa-current')
        end
      end

      context "when the item is a page number string" do
        let(:item) { "18" }

        it "includes the page number" do
          expect(page).to have_content("18")
        end

        it "is styled as the current page" do
          expect(page).to have_css('.usa-current')
        end
      end

      context "when the item is a gap" do
        let(:item) { :gap }

        specify do
          expect(page).to have_content("…")
        end
      end
    end

    describe "#url" do
      subject { component.url }

      before { render_component }

      it { is_expected.to eq(search_path(q: "jones", page: 10)) }
    end

    describe "#current?" do
      context "when item is a string" do
        let(:item) { "10" }

        it { is_expected.to be_current }
      end

      context "when item is an integer" do
        let(:item) { 10 }

        it { is_expected.not_to be_current }
      end
    end

    describe "#gap?" do
      context "when item is the gap symbol" do
        let(:item) { :gap }

        it { is_expected.to be_gap }
      end

      context "when item is not the gap symbol" do
        let(:item) { 10 }

        it { is_expected.not_to be_gap }
      end
    end
  end
end
