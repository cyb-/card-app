class CardCapacity
  # Configurations =============================================================
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming

  attr_reader :source, :target

  define_model_callbacks :initialize, only: :after

  # Singleton Methods ==========================================================

  class << self
    def availables
      @availables ||= Dir[Rails.root.join("app", "models", name.pluralize.underscore, "*.rb")].map{|f| File.basename(f, ".rb")}.map(&:classify).select{|c| exists?(c)}.freeze
    end
  end

  # Class Methods ==============================================================

  def self.class_for!(card_capacity_name)
    name.pluralize.constantize.const_get(card_capacity_name)
  end

  def self.exists?(card_capacity_name)
    begin
      class_for!(card_capacity_name).is_a?(Class)
    rescue NameError, LoadError
      false
    end
  end

  def self.for(card)
    raise ArgumentError, "Argument must be a Card" unless card.is_a?(Card)

    singular_field = "#{name.underscore}_name".to_sym
    plural_field = "#{name.underscore}_names".to_sym

    if card.respond_to?(singular_field)
      card_value = card.send(singular_field)
      return if card_value.blank? || !exists?(card_value)
      card_capacity_instance_for!(card_value, card)
    elsif card.respond_to?(plural_field)
      card_value = card.send(plural_field)
      card_value.uniq.compact.select{|val| exists?(val)}.map{|val| card_capacity_instance_for!(val, card)}
    else
      raise ArgumentError, "Card must has a capacity attribute (`#{singular_name}' or `#{plural_name}')"
    end
  end

  private_class_method def self.card_capacity_instance_for!(card_value, card)
    class_for!(card_value).new(card, card.versus)
  end

  # Instance Methods ===========================================================

  def initialize(source, target)
    @source = source
    @target = target
    run_callbacks(:initialize)
    Rails.logger.info "Use #{self.class.name} from #{source} to #{target}"
  end

  protected #===================================================================

  private #=====================================================================

end
