class Api::V1::BaseController < ActionController::API
  include ActionController::MimeResponds
  include ::Api::V1::Rescuable

end
