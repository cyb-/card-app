module Weaponable
  extend ActiveSupport::Concern

  included do
    field :weapon_name, type: String

    validates :weapon_name, inclusion: { in: ::Weapon.availables, allow_blank: true }

    before_fight  :use_weapon!,   if: :weapon?
    after_fighted :weapon_used!,  if: :weapon?

    private :use_weapon!
    private :weapon_used!
  end

  def set_weapon(value)
    value = value.class.name if value.is_a?(Weapon)
    raise ArgumentError, "Argument must be an existing weapon" unless ::Weapon.exists?(value)
    self.weapon_name = value
    @weapon = ::Weapon.for(self)
  end

  def weapon
    @weapon ||= ::Weapon.for(self)
  end

  def weapon?
    not weapon.blank?
  end

  def use_weapon!
    weapon.use!
  end

  def weapon_used!
    weapon.used!
  end

end
