class SpellGenerator < Rails::Generators::Base
  desc "Generates a new spell"

  source_root File.expand_path("../templates", __FILE__)

  argument :name, type: :string

  def create_model_file
    template "spell.rb.tt", File.join("app/models/spells/", "#{file_name}.rb")
  end

  def create_spec_file
    template "spell_spec.rb.tt", File.join("spec/models/spells", "#{file_name}_spec.rb")
  end

  def create_factory_file
    template "spell_factory.rb.tt", File.join("spec/factories/", "spells_#{file_name.pluralize}.rb")
  end

  def class_name
    name.singularize.classify
  end

  def file_name
    class_name.underscore
  end

end
