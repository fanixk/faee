source 'https://rubygems.org'

# ruby '2.1.2'
gem 'rails', '3.2.15'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

gem 'pg', '~> 0.16.0'
gem 'ancestry', '~> 2.0.0'
gem 'devise'
gem 'omniauth-twitter', '~> 1.0.0'
gem 'omniauth-facebook'
gem 'rails-i18n', '~> 3.0.0.pre'
gem 'bootstrap-sass', '2.3.2.1'
gem 'font-awesome-sass-rails'
gem 'paperclip', '~> 3.4.2'
gem 'ckeditor'
gem 'state_machine'
gem 'kaminari'
gem 'ransack'
gem 'activemerchant'
gem 'acts_as_list'
gem 'geocoder'
gem 'dalli', '~>2.6.4'
gem 'morrisjs-rails'
gem 'raphael-rails'
gem 'google-webfonts', :git => 'git://github.com/fanixk/Google-Webfonts-Helper.git'
gem 'chosen-rails'
gem 'prawn'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :production do
  gem 'aws-sdk'
  gem 'puma'
  gem 'memcachier'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.14.0'
  gem 'guard-rspec', '~> 3.0.2'
  gem 'hirb'
  gem 'guard-spork', '1.5.1'
  gem 'childprocess', '~> 0.3.9'
  gem 'spork', '0.9.2'
  gem 'terminal-notifier-guard', :require => RUBY_PLATFORM.include?('darwin') && 'terminal-notifier-guard'
end

group :development do
  gem "rails-erd"
  gem 'railroady'
  gem 'better_errors', '~> 0.9.0'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'meta_request', '~> 0.2.8'
  gem 'rails_best_practices'
  gem 'brakeman'
  gem 'bullet'
  gem 'debugger2'
  gem 'ruby-graphviz', :require => 'graphviz'
  gem 'fuubar'
end

group :test do
  gem 'capybara', '2.1.0'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'simplecov'
  # gem 'database_cleaner'
  gem 'rb-fsevent', :require => RUBY_PLATFORM.include?('darwin') && 'rb-fsevent'
  gem 'rb-inotify', '0.9.0', :require => RUBY_PLATFORM.include?('linux') && 'rb-inotify'
  gem 'libnotify', '0.5.9', :require => RUBY_PLATFORM.include?('linux') && 'libnotify'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
