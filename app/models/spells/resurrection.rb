class Spells::Resurrection < Spell
  # Configurations =============================================================
  after_fighted :resurrect_source!

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  protected #===================================================================

  private #=====================================================================

  def resurrect_source!
    source.resurrect!
  end

end
