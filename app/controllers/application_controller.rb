class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized(exception)
    if current_user.present?
      policy_name = exception.policy.class.to_s.underscore
      flash[:error] = t("#{policy_name}.#{exception.query}", scope: :pundit,
                default: :default)
      redirect_back fallback_location: root_path, status: :see_other
    else
      flash[:notice] = t('pundit.not_logged_in')

      if request.get? || request.head?
        store_location_for(:user, request.path)
      else
        store_location_for(:user, request.referer)
      end

      redirect_to new_user_session_path, status: :see_other
    end
  end
end
