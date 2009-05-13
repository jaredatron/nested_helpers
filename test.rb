require 'rubygems'
require 'activesupport'
require './lib/nested_helpers'

module RandomHelper
  
  define_nested_helper :accordion do
    
    define_nested_helper :drawr do
    end
    
  end
  
end

class Tester
  include RandomHelper
end

puts Tester.new.accordion do
  "love me"
end