# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in luhna.gemspec
gemspec

group :development do
  gem 'ruby-graphviz'

  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'

  gem 'fasterer', require: false

  gem 'mdl', require: false

  gem 'mry', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-thread_safety', require: false

  gem 'bundler-audit', require: false

  gem 'fuubar', require: false
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
end

group :development, :test do
  gem 'awesome_print'
end

group :test do
  gem 'simplecov', require: false
end
