$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module Dungeon
      autoload :Boss,    'dungeon/boss'
      autoload :Dungeon, 'dungeon/dungeon'
    end
  end
end
