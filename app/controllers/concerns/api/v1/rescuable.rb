module Api::V1::Rescuable
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |exception|
      respond_to do |format|
        format.any { head :internal_server_error }
      end
    end

    rescue_from Mongoid::Errors::Validations do |exception|
      respond_to do |format|
        format.any { head :unprocessable_entity }
      end
    end

    rescue_from Mongoid::Errors::DocumentNotFound, ActionController::RoutingError do |exception|
      respond_to do |format|
        format.any { head :not_found }
      end
    end

    rescue_from ActionController::UnknownFormat, ActionView::MissingTemplate do |exception|
      respond_to do |format|
        format.any { head :not_acceptable }
      end
    end
  end

end
