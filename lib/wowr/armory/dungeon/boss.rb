module Wowr
  module Armory
    module Dungeon
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

        # @example
        #   "Onyxia"
        # @return [String]
        attr_accessor :name

        alias_method :to_s, :name
        alias_method :to_i, :id

        def initialize(elem)
          @id   = elem[:id].to_i
          @key  = elem[:key]
          @type = elem[:type]
        end
      end
    end
  end
end
