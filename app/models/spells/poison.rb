class Spells::Poison < Spell
  # Configurations =============================================================
  before_fight  :poison_target!
  after_fighted :minimize_health!

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  protected #===================================================================

  private #=====================================================================

  def poison_target!
    target.strength_ratio = 0.5
    target.shield_ratio = target.shield_ratio / 2
  end

  def minimize_health!
    target.health = target.health / 2
  end

end
