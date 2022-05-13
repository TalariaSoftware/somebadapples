require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include Rails.application.routes.url_helpers

  context "when the user is unauthorized" do
    controller do
      def index
        policy = DocumentPolicy.new(current_user, nil)
        raise Pundit::NotAuthorizedError.new(policy: policy, query: 'index')
      end

      def create
        policy = DocumentPolicy.new(current_user, nil)
        raise Pundit::NotAuthorizedError.new(policy: policy, query: 'create')
      end
    end

    context "when the user is logged in" do
      controller do
        def current_user
          @current_user ||= FactoryBot.create :user # rubocop:disable RSpec/FactoryBot/SyntaxMethods
        end
      end

      it "sets an error message" do
        get :index
        expect(flash[:error]).to eq("You are not authorized for that.")
      end

      it "redirects to a different resource" do
        get :index
        expect(response).to have_http_status(:see_other)
      end

      context "when there is no referrer" do
        it "redirects to root" do
          get :index
          expect(response).to redirect_to('/')
        end
      end

      context "when there is a local referrer" do
        before { request.headers['Referer'] = 'http://test.host/orig_path' }

        it "redirects to the referer" do
          get :index
          expect(response).to redirect_to('/orig_path')
        end
      end

      context "when there is a referrer from another host" do
        before { request.headers['Referer'] = 'http://naaga.org/orig_path' }

        it "redirects to the root path" do
          get :index
          expect(response).to redirect_to('/')
        end
      end
    end

    context "when the user is not logged in" do
      controller do
        def current_user
          nil
        end
      end
      before { request.headers['Referer'] = 'http://test.host/orig_path' }

      it "sets an notice message" do
        get :index
        expect(flash[:notice]).to eq("Sign in to continue.")
      end

      it "redirects to a different resource" do
        get :index
        expect(response).to have_http_status(:see_other)
      end

      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end

      context "when the request is a get" do
        it "remembers the current path" do
          get :index
          expect(controller.stored_location_for(:user)).to eq('/anonymous')
        end
      end

      context "when the request is not a get" do
        it "remembers the referrer path" do
          post :create
          expect(controller.stored_location_for(:user)).to eq('/orig_path')
        end
      end
    end
  end
end
