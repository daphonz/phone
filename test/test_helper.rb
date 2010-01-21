$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'

require 'test/unit'
require 'phone'

# Create some psuedo-classes to simulate a Rails-environment #

module ActiveRecord
  class Base; end;
end

# Make two "models" that simulate a class-name clash if we had these in Rails
class Country < ActiveRecord::Base;end;

class Phone < ActiveRecord::Base;end;
