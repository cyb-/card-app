class Weapon < CardCapacity
  # Configurations =============================================================
  define_model_callbacks :using

  # Callbacks ==================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  def use!
    run_callbacks(:using) do
      using!
    end
  end

  def used!
  end

  private #=====================================================================

  def using!
  end

end
