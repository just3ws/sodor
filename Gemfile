# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

ruby '~> 2.5.1'

gem 'awesome_print'
gem 'byebug'
gem 'pry'
gem 'pry-byebug'
gem 'ruby-graphviz'

group :development do
  gem 'bundler-audit', require: false
  gem 'fasterer', require: false
  gem 'fuubar', require: false
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'mdl', require: false
  gem 'mry', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-thread_safety', require: false
end

group :test do
  gem 'simplecov', require: false
end
