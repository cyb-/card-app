class Spell < CardCapacity
  # Configurations =============================================================
  define_model_callbacks :fight,      only: :before
  define_model_callbacks :fighted,    only: :after

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  def before_fight!
    run_callbacks(:fight)
  end

  def after_fight!
    run_callbacks(:fighted)
  end

  private #=====================================================================

end
