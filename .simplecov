# frozen_string_literal: true

SimpleCov.start do
  add_filter '/spec/'
  add_group 'Libraries', 'lib'
end
