require "rails/generators/mongoid_generator"

class CardGenerator < Rails::Generators::NamedBase
  desc "Generates a new custom card type"

  source_root File.expand_path("../templates", __FILE__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type"

  class_option :weaponable, type: :boolean, default: false, desc: "The card has a weapon"
  class_option :howlable, type: :boolean, default: false, desc: "The card has a howl"
  class_option :spellable, type: :boolean, default: false, desc: "The card has spells"

  def create_model_file
    template "card.rb.tt", File.join("app/models/cards", class_path, "#{file_name}.rb")
  end

  def create_spec_file
    template "card_spec.rb.tt", File.join("spec/models/cards", class_path, "#{file_name}_spec.rb")
  end

  def create_factory_file
    template "card_factory.rb.tt", File.join("spec/factories/", "cards_#{file_name.pluralize}.rb")
  end

  def create_api_v1_view_file
    template "card.json.jbuilder.rb.tt", File.join("app/views/api/v1/cards", class_path, "_#{file_name}.json.jbuilder")
  end

end
