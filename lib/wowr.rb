#
# Wowr - Ruby library for the World of Warcraft Armory
# http://wowr.rubyforge.org/
# Written by Ben Humphreys
# http://benhumphreys.co.uk/
# Maintained By Peter Wood
# http://narwar.net/
#
# Author:: Ben Humphreys
# Author:: Peter Wood

require 'net/http'
require 'net/https'
require 'fileutils'

begin
  require 'bundler'
rescue LoadError
  require 'rubygems'
  require 'bundler'
end
Bundler.require

require 'core_ext/class'

require 'wowr/api'
require 'wowr/calendar'
require 'wowr/classes'
require 'wowr/exceptions'
require 'wowr/money'
