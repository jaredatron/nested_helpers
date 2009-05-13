begin
  require File.join(File.dirname(__FILE__), 'lib', 'nested_helpers') # From here
rescue LoadError
  require 'nested_helpers' # From gem
end