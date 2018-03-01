class Api::V1::Games::WinnerController < Api::V1::Games::BaseController
  before_action :set_game

  def show
    head :no_content and return unless @game.finished?
  end

end
