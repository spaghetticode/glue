require 'rspec/expectations'

RSpec::Matchers.define :have_private_method do |expected|
  match do |actual|
    actual.private_methods.include? expected.to_sym
  end
end
