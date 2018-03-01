class Api::V1::Players::CardsController < Api::V1::Players::BaseController
  before_action :set_player

  def index
    @cards = @player.cards

    render "api/v1/cards/index"
  end

end
