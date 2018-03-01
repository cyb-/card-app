class Player
  include Mongoid::Document
  include Mongoid::Timestamps
  # Configurations =============================================================

  # Mongoid ====================================================================
  field :name, type: String

  # Relations ==================================================================
  has_and_belongs_to_many :cards
  has_and_belongs_to_many :games

  # Callbacks ==================================================================

  # Validations ================================================================
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Scopes =====================================================================

  # Class Methods ==============================================================

  # Instance Methods ===========================================================

  def to_s
    name
  end

  private #=====================================================================

end
