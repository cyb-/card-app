class Rules::MagusVsWarrior < Rule
  # Configurations =============================================================
  attr_reader :magus, :warrior

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
    run_callbacks(:fighting) do
      if magus.spell_names.include?("Shield") && magus.compiled_strength >= warrior.compiled_strength / 5
        Rails.logger.info "Magus wins because he has Shield spell and more than 1/5 of warrior strength".colorize(:magenta)
        warrior.strength_ratio = 0
        return @winner = magus
      elsif magus.spell_names.include?("Shield") && magus.compiled_strength >= warrior.strength * 3
        Rails.logger.info "Magus wins because he has Shield spell and more then 3/1 of warrior strength".colorize(:magenta)
        return @winner = magus
      else
        Rails.logger.info "Running classic fight because cannot apply special rule".colorize(:magenta)
        fight!
      end
    end
    set_winner!
  end

  def identify_cards!
    @magus = @card1
    @warrior = @card2
  end

end
