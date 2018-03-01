class Spells::MagicShield < Spell
  # Configurations =============================================================
  before_fight :apply_magic_shield!

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  protected #===================================================================

  private #=====================================================================

  def apply_magic_shield!
    target.strength_ratio *= 0.5
  end

end
