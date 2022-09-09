source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.1"

gem "bcrypt"
gem "bootsnap", ">= 1.4.4", require: false
gem "chartkick"
gem "cocoon"
gem "config"
gem "faker"
gem "figaro"
gem "font-awesome-sass", "~> 6.1.2"
gem "groupdate"
gem "htmlbeautifier"
gem "image_processing", "~> 1.2"
gem "jbuilder", "~> 2.7"
gem "mysql2"
gem "pagy"
gem "paranoia", "~> 2.2"
gem "pry"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6", ">= 6.1.6.1"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "simple_form"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"
gem "simplecov-rcov"
gem "simplecov"
gem "whenever"
gem "devise"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "bullet"
  gem "listen", "~> 3.3"
  gem "pry-rails"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
  gem "shoulda-matchers", "~> 5.0"
  gem "factory_bot_rails"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development, :test do
  gem "rspec-rails", "~> 4.0.1"
end
