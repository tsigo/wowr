module Wowr
  module Armory
    module Guild
      # A player guild containing members
      # Abstract
      class Base
        attr_reader :name, :url, :realm
        # :roster_url, :stats_url, :stats_url_escape,
        alias_method :to_s, :name

        def initialize(elem)
          if (elem%'guildHeader')
            guild = (elem%'guildHeader')
          else
            guild = elem
          end

          @name         = guild[:name]
          @url          = guild[:url]
          @realm        = guild[:realm]
        end
      end

    end
  end
end
