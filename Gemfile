source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',                        '~> 5.1.5'

gem 'bootstrap-sass'
gem 'coffee-rails',                 '~> 4.2'
gem 'colorize'
gem 'font-awesome-sass',            '~> 5.0.6'
gem 'hashie'
gem 'jbuilder',                     '~> 2.5'
gem 'js-routes'
gem 'mongoid'
gem 'pry'
gem 'pry-rails'
gem 'puma',                         '~> 3.7'
gem 'rails-i18n'
gem 'sass-rails',                   '~> 5.0'
gem 'turbolinks',                   '~> 5'
gem 'uglifier',                     '>= 1.3.0'


group :development, :test do
  gem 'byebug',                     platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara',                   '~> 2.13'
  gem 'dotenv-rails'
  gem 'factory_bot_rails',          '~> 4.0'
  gem 'faker'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'listen',                     '>= 3.0.5', '< 3.2'
  gem 'looksee'
  gem 'spring'
  gem 'spring-watcher-listen',      '~> 2.0.0'
  gem 'web-console',                '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'shoulda-matchers',           '~> 3.1'
  gem 'shoulda-callback-matchers',  '~> 1.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
