module Wowr
  module Armory
    module Dungeon
      # = Bosses
      #
      # An extension of Hash that allows use of either an Integer-based ID or a String
      # as a key, while only storing one value
      #
      # @example Assignment
      #   bosses = Bosses.new
      #   bosses[10184, 'onyxia'] = "A boss instance"
      # @example Access
      #   bosses[10184] # => "A boss instance"
      #   bosses['onyxia'] # => "A boss instance"
      #   bosses.size # => 1
      class Bosses < Hash
        def initialize(*args)
          super(*args)

          @_id_map = {}
        end

        def []=(id, key, value)
          # Use the key by default
          super(key, value)

          # Store the ID internally, mapped to the key, so we can get it later
          @_id_map[id] = key
        end

        def [](key)
          # Get by ID
          if key.kind_of?(Integer)
            super(@_id_map[key])
          else
            super
          end
        end
      end
    end
  end
end
