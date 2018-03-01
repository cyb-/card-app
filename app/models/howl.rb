class Howl < CardCapacity
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

  private #=====================================================================

  def using!
  end

end
