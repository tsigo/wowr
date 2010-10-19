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
require 'cgi'
require 'fileutils'

# gems
require "rubygems"
require "bundler"
Bundler.setup

require 'json'
require 'hpricot'

require 'core_ext/class'

require 'wowr/api'

require 'wowr/exceptions.rb'

require 'wowr/classes'
require 'wowr/calendar.rb'
require 'wowr/character.rb'
require 'wowr/achievements.rb'
require 'wowr/dungeon.rb'
