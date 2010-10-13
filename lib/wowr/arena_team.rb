require 'armory/arena_team/base'
require 'armory/arena_team/emblem'
require 'armory/arena_team/full'
require 'armory/arena_team/search'

module Wowr
  module Classes
    class ArenaTeam       < Wowr::Armory::ArenaTeam::Base; end
    class SearchArenaTeam < Wowr::Armory::ArenaTeam::Search; end
    class FullArenaTeam   < Wowr::Armory::ArenaTeam::Full; end
    class ArenaTeamEmblem < Wowr::Armory::ArenaTeam::Emblem; end
  end
end
