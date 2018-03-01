class Rules::DeveloperVsDragon < Rule
  # Configurations =============================================================
  attr_reader :developer, :dragon

  # Callbacks ==================================================================
  after_initialize :identify_cards!

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  protected #===================================================================

  # def fight!
  #   super
  # end

  # def fightable?
  #   super
  # end

  private #=====================================================================

  def fighting!
    Rails.logger.info "Developer is the winner because it's a developer !!".colorize(:magenta)
    @winner = developer
  end

  def identify_cards!
    @developer = @card1
    @dragon = @card2
  end

end
