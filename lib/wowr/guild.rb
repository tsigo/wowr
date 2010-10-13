$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'character.rb'

require 'armory/guild/base'
require 'armory/guild/full'
require 'armory/guild/search'

module Wowr #:nodoc:
  module Classes #:nodoc:
    class Guild       < Wowr::Armory::Guild::Base; end
    class SearchGuild < Wowr::Armory::Guild::Search; end
    class FullGuild   < Wowr::Armory::Guild::Full; end
  end
end
