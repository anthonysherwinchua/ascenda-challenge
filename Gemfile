source "https://rubygems.org"

ruby "3.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# Use postgres as the database for Active Record
gem "pg"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'

gem "sidekiq", "~> 7.2"

gem 'after_party'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]

  # Use Rspec to test
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
end

group :test do
  # Use FactoryBot to replace fixtures
  gem 'factory_bot_rails', '~> 6.2'

  # Use Shoulda Matchers for one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 5.0'

  # Use JSON Matcher to validate the JSON returned by your Rails JSON APIs
  gem 'json_matchers'

  # Use Faker to generate random data
  gem 'faker'
end
