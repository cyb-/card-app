class ApplicationController < ActionController::Base
  include Localizable
  include Rescuable

  protect_from_forgery with: :exception

end
