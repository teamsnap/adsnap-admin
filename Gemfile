# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.0'

gem 'rails'

gem 'activerecord-sqlserver-adapter', require: false
gem 'ar_lazy_preload'
gem 'audited'
gem 'aws-sdk-s3'
gem 'devise'
gem 'dotenv'
gem 'fast_blank'
gem 'google-cloud-storage'
gem 'image_processing'
gem 'jwt'
gem 'lograge'
gem 'adsnap-admin', github: 'teamsnap/net_http_ssl_fix', require: 'net_http_ssl_fix'
gem 'mysql2', '0.5.3', require: false
gem 'net_http_ssl_fix', github: 'teamsnap/net_http_ssl_fix', require: 'net_http_ssl_fix'
gem 'oj'
gem 'pg', '1.2.3', require: false
gem 'puma'
gem 'shakapacker'
gem 'sqlite3'
gem 'tiny_tds', '2.1.5', require: false
gem 'tzinfo-data'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'yard', require: false
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'web-console'
end
