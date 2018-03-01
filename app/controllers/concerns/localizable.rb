module Localizable
  extend ActiveSupport::Concern

  included do
    before_action :set_locale!

    private :set_locale!
    private :user_locale
  end

  def set_locale!
    I18n.locale = (params[:locale].present? && I18n.available_locales.map(&:to_s).include?(params[:locale])) ? params[:locale] : user_locale
    cookies.permanent[:locale] = I18n.locale
  end

  def user_locale
    return cookies[:locale] if I18n.available_locales.map(&:to_s).include?(cookies[:locale])
    unless request.env['HTTP_ACCEPT_LANGUAGE'].nil?
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).each do |locale|
        return locale if I18n.available_locales.map(&:to_s).include?(locale)
      end
    end
    I18n.default_locale
  end

end
