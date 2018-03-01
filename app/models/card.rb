class Card
  include Mongoid::Document
  # Configurations =============================================================
  attr_accessor :versus

  define_model_callbacks :fight,    only: :before
  define_model_callbacks :fighted,  only: :after

  # Mongoid ====================================================================
  field :name,      type: String
  field :health,    type: Integer, default: 100
  field :strength,  type: Integer, default: 5
  field :shield,    type: Integer, default: 5

  # Relations ==================================================================
  has_and_belongs_to_many :players

  # Callbacks ==================================================================

  # Validations ================================================================
  validates :name, presence: true, uniqueness: { scope: :_type, case_sensitive: false }

  # Scopes =====================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  def to_s
    "#{self.class.name.demodulize}: #{name}"
  end

  def strength_ratio
    @strength_ratio ||= 1.0
  end

  def shield_ratio
    @shield_ratio ||= 1.0
  end

  def strength_ratio=(ratio)
    @strength_ratio = ratio.to_f
  end

  def shield_ratio=(ratio)
    @shield_ratio = ratio.to_f
  end

  def compiled_strength
    (strength * strength_ratio).round
  end

  def compiled_shield
    (shield * shield_ratio).round
  end

  def damages
    damages = compiled_strength - (versus.compiled_shield rescue 0)
    damages <= 0 ? 0 : damages
  end

  # ============================================================================

  def before_fight!
    Rails.logger.info "Running before fight callbacks for #{to_s}: #{health}|#{compiled_strength}|#{compiled_shield}".colorize(:light_cyan)
    run_callbacks(:fight)
    Rails.logger.info "Runned before fight callbacks for #{to_s}: #{health}|#{compiled_strength}|#{compiled_shield}".colorize(:cyan)
  end

  def after_fight!
    Rails.logger.info "Running after fight callbacks for #{to_s}: #{health}|#{compiled_strength}|#{compiled_shield}".colorize(:light_cyan)
    run_callbacks(:fighted)
    Rails.logger.info "Runned after fight callbacks for #{to_s}: #{health}|#{compiled_strength}|#{compiled_shield}".colorize(:cyan)
  end

  def versus!(other)
    raise ArgumentError, "Argument must be a Card" unless other.is_a?(Card)
    self.versus = other
    other.versus = self
    rule.winner
  end

  def kill!
    self.health = 0
  end

  def resurrect!
    self.health = self.class.fields["health"].default_val
  end

  def attacked_by!(other)
    d = other.compiled_strength - compiled_shield
    self.health -= (d <= 0 ? 0 : d)
  end

  def winner?
    false
  end

  protected #===================================================================

  def rule_class_name
    sorted_with_versus.map{ |c| c.class.name.demodulize }.join("Vs")
  end

  private #=====================================================================

  def sorted_with_versus
    [self, versus].compact.sort{ |a,b| a.class.name <=> b.class.name }
  end

  def rule_class
    begin
      klass = ::Rules.const_get(rule_class_name)
      raise LoadError unless klass.is_a?(Class)
      klass
    rescue NameError, LoadError
      Rule
    end
  end

  def rule
    @rule ||= rule_class.new(*sorted_with_versus)
  end

end
