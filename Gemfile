source "https://rubygems.org"

ruby "3.2.0"

gem "rails", "~> 7.1.0"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# DB
gem 'mysql2', '~> 0.5'

# 認証
gem 'devise'

# -------------------------
# 開発・テスト共通
# -------------------------
group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

# -------------------------
# 開発のみ
# -------------------------
group :development do
  gem "web-console"
  gem 'rubocop', require: false
end

# -------------------------
# テストのみ
# -------------------------
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

# -------------------------
# 本番
# -------------------------
group :production do
  gem 'pg'
end