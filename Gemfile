source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"
# Use Slim (template engine)
gem "slim-rails"
# Hotwire Javascript on Turbo
gem "turbo-rails"
# Hotwire Javascript/HTML helper
gem "stimulus-rails"
# Javascript imports
gem "importmap-rails", "~> 2.1"
# ENV variables
gem "dotenv"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Easily create Database objects that respect Active Record
  gem "factory_bot_rails"

  # Fake database data creator
  gem "faker"
end

group :development do
  # Omakase Ruby styling for Rails
  gem "rubocop-rails-omakase", require: false

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Reload on HTML change
  gem "hotwire-spark"

  # Procfile concurrent runner
  gem "foreman"
end

group :test do
  # Database Cleaner to ensure clean databases for test runs
  gem "database_cleaner-active_record", ">= 2.2.0"

  # RSPEC Testing gem for Rails
  gem "rspec-rails"

  # ActiveRecord model validators
  gem "shoulda-matchers", require: false

  # Coverage report
  gem "simplecov"
end
