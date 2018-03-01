class Rules::MagusVsMagus < Rule
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
    Rails.logger.info "#{self.class.name} defines winner using #{card1}: (#{compiled_rule_for(card1)}) vs #{card2}: (#{compiled_rule_for(card2)})".colorize(:magenta)
    @winner = case compiled_rule_for(card1) <=> compiled_rule_for(card2)
              when 1 then card1
              when -1 then card2
              else super
              end
  end

  def compiled_rule_for(card)
    (1 + 0.3 * card.spell_names.size) * card.compiled_strength
  end

end
