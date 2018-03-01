class WeaponGenerator < Rails::Generators::Base
  desc "Generates a new weapon"

  source_root File.expand_path("../templates", __FILE__)

  argument :name, type: :string

  def create_model_file
    template "weapon.rb.tt", File.join("app/models/weapons/", "#{file_name}.rb")
  end

  def create_spec_file
    template "weapon_spec.rb.tt", File.join("spec/models/weapons", "#{file_name}_spec.rb")
  end

  def create_factory_file
    template "weapon_factory.rb.tt", File.join("spec/factories/", "weapons_#{file_name.pluralize}.rb")
  end

  def class_name
    name.singularize.classify
  end

  def file_name
    class_name.underscore
  end

end
