class HowlGenerator < Rails::Generators::Base
  desc "Generates a new howl"

  source_root File.expand_path("../templates", __FILE__)

  argument :name, type: :string

  def create_model_file
    template "howl.rb.tt", File.join("app/models/howls/", "#{file_name}.rb")
  end

  def create_spec_file
    template "howl_spec.rb.tt", File.join("spec/models/howls", "#{file_name}_spec.rb")
  end

  def create_factory_file
    template "howl_factory.rb.tt", File.join("spec/factories/", "howls_#{file_name.pluralize}.rb")
  end

  def class_name
    name.singularize.classify
  end

  def file_name
    class_name.underscore
  end

end
