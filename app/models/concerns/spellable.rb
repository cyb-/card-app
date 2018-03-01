module Spellable
  extend ActiveSupport::Concern

  included do
    field :spell_names, type: Array, default: []

    validate :validate_spells

    before_fight  :spells_before_fight!
    after_fighted :spells_after_fight!

    after_save    :refresh_spells!

    private :spells_before_fight!
    private :spells_after_fight!
    private :refresh_spells!
    private :validate_spells
  end

  def add_spell!(spell_name)
    raise ArgumentError, "Argument must be an existing spell" unless ::Spell.exists?(spell_name)
    add_to_set(spell_names: spell_name)
    refresh_spells!
  end

  def delete_spell!(spell_name)
    pull(spell_names: spell_name)
    refresh_spells!
  end

  def spells
    @spells or refresh_spells! and return @spells
  end

  def spells_before_fight!
    spells.each{|s| s.before_fight!}
  end

  def spells_after_fight!
    spells.each{|s| s.after_fight!}
  end

  def refresh_spells!
    @spells = ::Spell.for(self)
  end

  def validate_spells
    if !spell_names.is_a?(Array)
      errors.add(:spell_names, :invalid)
    else
      spell_names.uniq!
      spell_names.each do |spell_name|
        errors[:spell] << "`#{spell_name}' #{I18n.t(:inclusion, scope: [:errors, :messages])}" unless ::Spell.exists?(spell_name)
      end
    end
  end

end
