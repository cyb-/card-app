class Cards::Developer < Card
  # Configurations =============================================================
  include Howlable
  include Spellable
  include Weaponable

  # Mongoid ====================================================================

  # Callbacks ==================================================================

  # Validations ================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  def winner?
    unless name.downcase.match(/ruby on rails/).nil?
      Rails.logger.info "RoR Developer wins because it's a RoR developer ;)".colorize(:light_magenta)
      return true
    end
    super
  end

  protected #===================================================================

  private #=====================================================================

end
