class RuleGenerator < Rails::Generators::Base
  desc "Generates a new custom card versus rule"

  source_root File.expand_path("../templates", __FILE__)

  argument :class1, type: :string
  argument :class2, type: :string

  def create_model_file
    template "rule.rb.tt", File.join("app/models/rules/", "#{file_name}.rb")
  end

  def create_spec_file
    template "rule_spec.rb.tt", File.join("spec/models/rules", "#{file_name}_spec.rb")
  end

  def create_factory_file
    template "rule_factory.rb.tt", File.join("spec/factories/", "rules_#{file_name.pluralize}.rb")
  end

  def class_name
    sorted_class_names.join("Vs")
  end

  def file_name
    class_name.underscore
  end

  def sorted_class_names
    [class1, class2].compact.map(&:classify).sort{|a,b| a <=> b}
  end

end
