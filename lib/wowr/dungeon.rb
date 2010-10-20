$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'armory/dungeon/dungeon'
require 'armory/dungeon/boss'

module Wowr
  module Classes
    class Dungeon < Wowr::Armory::Dungeon::Dungeon; end
    class Boss < Wowr::Armory::Dungeon::Boss; end
  end
end
