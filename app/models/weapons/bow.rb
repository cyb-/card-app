class Weapons::Bow < Weapon
  # Configurations =============================================================

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  protected #===================================================================

  private #=====================================================================

  def using!
    source.strength_ratio = 3
  end

end