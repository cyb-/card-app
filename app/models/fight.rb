class Fight
  include Mongoid::Document
  include Mongoid::Timestamps
  # Configurations =============================================================
  define_model_callbacks :fighting

  # Mongoid ====================================================================

  # Relations ==================================================================
  embedded_in :game, inverse_of: :fights

  embeds_many :hands, inverse_of: :fight

  belongs_to :winner, class_name: "Player", optional: true

  accepts_nested_attributes_for :hands

  # Callbacks ==================================================================
  before_create :fight!, if: :valid?

  # Validations ================================================================
  validates_length_of :hands, minimum: 2, maximum: ::Game::MAX_PLAYERS

  # Scopes =====================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  private #=====================================================================

  def card1
    @card1 ||= hands.first.card
  end

  def card2
    @card2 ||= hands.last.card
  end

  def fight!
    @winned_card = nil
    Rails.logger.info "Start fighting between #{hands.first.player} and #{hands.last.player}".colorize(:light_yellow)
    run_callbacks(:fighting) do
      if card1.winner? && !card2.winner?
        @winned_card = card1
      elsif card2.winner? && !card1.winner?
        @winned_card = card2
      else
        @winned_card = card1.versus!(card2)
      end
    end
    set_winner!(@winned_card)
  end

  def set_winner!(card)
    return if card.nil?
    if card.name == hands.first.card.name && card._type == hands.first.card._type
      self.winner = hands.first.player
    elsif card.name == hands.last.card.name && card._type == hands.last.card._type
      self.winner = hands.last.player
    end
    if winner?
      Rails.logger.info "#{winner} wins this fight with #{card} !".colorize(:light_green)
    else
      Rails.logger.info "Equality between #{hands.first.player} and #{hands.last.player} for this fight !".colorize(:light_red)
    end
  end

end
