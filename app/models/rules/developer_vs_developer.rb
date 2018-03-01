class Rules::DeveloperVsDeveloper < Rule
  # Configurations =============================================================

  # Callbacks ==================================================================

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
    Rails.logger.info "I can't determine who is the winner between two developers, so destiny will do it for me ;)".colorize(:light_magenta)
    @winner = [card1, card2].sample
  end

end
