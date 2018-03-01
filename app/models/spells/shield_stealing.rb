class Spells::ShieldStealing < Spell
  # Configurations =============================================================
  before_fight :steal_shield!

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  protected #===================================================================

  private #=====================================================================

  def steal_shield!
    source.shield += target.shield
    source.shield_ratio += target.shield_ratio
  end

end
