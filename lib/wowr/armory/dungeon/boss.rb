module Wowr
  module Armory
    module Dungeon
      # Note Key or id can be nil
      # Not both
      class Boss
        attr_reader :id, :key, :name, :type

        alias_method :to_s, :name
        alias_method :to_i, :id

        def initialize(elem)
          @id     = elem[:id].to_i if elem[:id].to_i
          @key    = elem[:key] if elem[:key]
          @id     = @key if !elem[:id].to_i

          @type     = elem[:type]
        end

        def add_name_data(elem)
          @name = elem['name']
        end
      end
    end
  end
end
