class Rule
  # Configurations =============================================================
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming

  attr_reader :card1, :card2

  define_model_callbacks :initialize, only: :after
  define_model_callbacks :fighting

  # Callbacks ==================================================================
  before_fighting  :run_cards_before_callbacks!
  after_fighting   :run_cards_after_callbacks!

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  def initialize(card1, card2)
    @card1 = card1
    @card2 = card2
    run_callbacks(:initialize)
    Rails.logger.info "#{self.class.name} will be used for #{card1} versus #{card2}".colorize(:light_magenta)
  end

  def winner
    @winner or fighting! and return @winner
  end

  protected #===================================================================

  def fight!
    begin
      prev_health1 = card1.health
      prev_health2 = card2.health
      card1.health -= card2.damages
      card2.health -= card1.damages
      Rails.logger.info "Fighting with #{self.class.name}: #{card1} (#{prev_health1} => #{card1.health}) versus #{card2} (#{prev_health2} => #{card2.health})".colorize(:light_white)
    end while fightable?
  end

  def fightable?
    card1.health > 0 && card2.health > 0 && (!card1.damages.zero? || !card2.damages.zero?)
  end

  private #=====================================================================

  def fighting!
    run_callbacks(:fighting) do
      fight!
    end
    set_winner!
  end

  def set_winner!
    @winner = case card1.health <=> card2.health
              when 1 then card1
              when -1 then card2
              else nil
              end
  end

  def run_cards_before_callbacks!
    card1.before_fight!
    card2.before_fight!
  end

  def run_cards_after_callbacks!
    card1.after_fight!
    card2.after_fight!
  end

end
