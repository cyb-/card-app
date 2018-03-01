class Spells::StrengthStealing < Spell
  # Configurations =============================================================
  before_fight :steal_strength!

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  protected #===================================================================

  private #=====================================================================

  def steal_strength!
    source.strength += target.strength
    source.strength_ratio += target.strength_ratio
  end

end
