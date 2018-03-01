class Game
  include Mongoid::Document
  include Mongoid::Timestamps
  # Configurations =============================================================
  MAX_FIGHTS = 10.freeze
  MAX_PLAYERS = 2.freeze

  # Mongoid ====================================================================

  # Relations ==================================================================
  embeds_many :fights, inverse_of: :game

  has_and_belongs_to_many :players

  # Callbacks ==================================================================

  # Validations ================================================================
  validates_length_of :fights,  maximum: MAX_FIGHTS
  validates_length_of :player_ids, minimum: 2, maximum: MAX_PLAYERS

  # Scopes =====================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  def finished?
    fights.count == MAX_FIGHTS
  end

  def winner
    @winner or set_winner and return @winner
  end

  def looser
    @looser or set_winner and return @looser
  end

  def winner_fights_count
    @winner_fights_count or set_winner and return @winner_fights_count
  end

  def looser_fights_count
    @looser_fights_count or set_winner and return @looser_fights_count
  end

  private #=====================================================================

  def set_winner
    return unless finished?
    grouped_fights_count = {}
    fights.group_by(&:winner).each{|k,v| grouped_fights_count[k] = v.size}
    grouped_fights_count.delete(nil)
    max = grouped_fights_count.max_by{|k,v| v}
    min = grouped_fights_count.min_by{|k,v| v}
    return nil if max.nil? || min.nil? || (grouped_fights_count.size > 1 && min.last == max.last && min.first.id != max.first.id)
    @winner = max.first
    @looser = players.to_a.detect{|p| p.id != @winner.id}
    @winner_fights_count = max.last
    @looser_fights_count = fights.to_a.select{|f| f.winner_id == @looser.id}.size
  end

end
