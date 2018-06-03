source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'better_errors'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'devise-i18n', '~> 1.6', '>= 1.6.2'
gem 'rails-i18n', '~> 5.1'
gem 'pry', '~> 0.11.3'
gem 'pry-rails', '~> 0.3.6'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'
gem 'bootstrap-will_paginate', '~> 1.0'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'jquery-turbolinks', '~> 2.1.0'
gem 'paperclip', '~> 5.2.1'
gem 'paperclip-i18n', '~> 4.3'
gem 'time_difference', '~> 0.7.0'
gem 'enumerate_it', '~> 1.6', '>= 1.6.1'
gem 'awesome_print', '~> 1.8.0'
gem 'pg', '~> 1.0'
gem 'lerolero_generator', '~> 1.0', '>= 1.0.1'
gem 'bootsnap', '~> 1.3'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'aws-sdk', '2.10.47'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap', '3.3.7'
  gem 'rails-assets-bootstrap.growl'
  gem 'rails-assets-animate-css'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
