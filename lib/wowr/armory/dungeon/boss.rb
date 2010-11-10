module Wowr
  module Armory
    module Dungeon
      # Note Key or id can be nil, but not both - TODO: verify that this statement is still true - 11/09/10

      # = Boss
      #
      # Represents a <tt>boss</tt> element
      #
      # == Relevant XML example:
      #
      #   <boss id="10184" key="onyxia" type="npc">
      #     <lootTable difficulty="n" id="10184" type="npc"/>
      #     <lootTable difficulty="h" id="36538" type="npc"/>
      #   </boss>
      class Boss
        # @return [Integer]
        attr_reader :id

        # @example
        #   "onyxia"
        # @return [String]
        attr_reader :key

        # @example
        #   "npc"
        # @return [String]
        attr_reader :type

        attr_reader :name

        alias_method :to_s, :name
        alias_method :to_i, :id

        def initialize(elem)
          @id     = elem[:id].to_i if elem[:id].to_i
          @key    = elem[:key] if elem[:key]
          @id     = @key if !elem[:id].to_i # TODO: see statement above and add to 'boss_spec.rb' if true - 11/09/10

          @type     = elem[:type]
        end

        def add_name_data(elem)
          @name = elem['name']
        end
      end
    end
  end
end
