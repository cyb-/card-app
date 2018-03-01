class Api::V1::CardsController < Api::V1::BaseController
  before_action :set_card, only: [:show]

  def index
    @cards = Card.all
  end

  def show
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

end
