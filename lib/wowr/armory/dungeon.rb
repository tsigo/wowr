$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module Dungeon
      autoload :Boss,    'dungeon/boss'
      autoload :Bosses,  'dungeon/bosses'
      autoload :Dungeon, 'dungeon/dungeon'
    end
  end
end
