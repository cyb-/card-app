module Howlable
  extend ActiveSupport::Concern

  included do
    field :howl_name, type: String

    validates :howl_name, inclusion: { in: ::Howl.availables, allow_blank: true }

    after_fighted :use_howl!, if: :howl?

    private :use_howl!
  end

  def set_howl(value)
    value = value.class.name if value.is_a?(Howl)
    raise ArgumentError, "Argument must be an existing howl" unless ::Howl.exists?(value)
    self.howl_name = value
    @howl = ::Howl.for(self)
  end

  def howl
    @howl ||= ::Howl.for(self)
  end

  def howl?
    not howl.blank?
  end

  def use_howl!
    howl.use!
  end

end
