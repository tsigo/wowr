$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module ArenaTeam
      autoload :Base,         'arena_team/base'
      autoload :Emblem,       'arena_team/emblem'
      autoload :Full,         'arena_team/full'
      autoload :SearchResult, 'arena_team/search_result'
    end
  end
end
