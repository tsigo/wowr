module Wowr
  # = Armory
  #
  # A collection of classes representing XML elements on the Armory
  #
  # Also provides a set of helper methods for dealing with Armory data
  module Armory
    # @see #damage_type
    DAMAGE_TYPES = [:physical, :holy, :fire, :nature, :frost, :shadow, :arcane].freeze

    ELEMENT_TYPES = DAMAGE_TYPES.dup.delete_if { |v| v == :physical }.freeze

    # @see #faction
    FACTIONS = [:alliance, :horde].freeze

    # @see #power_type
    POWER_TYPES = {:e => :energy, :f => :focus, :m => :mana, :p => :runic_power, :r => :rage}.freeze

    # @see #quality
    QUALITIES = [:trash, :common, :uncommon, :rare, :epic, :legendary, :artifact, :heirloom].freeze

    class << self
      # Maps an integer-based damage type to its name
      #
      # @example
      #   >> Armory.damage_type(3)
      #   => :fire
      #   >> Armory.damage_type(6)
      #   => :arcane
      # @raise [ArgumentError] Invalid damage type
      # @param [Integer] type
      # @return [Symbol]
      def damage_type(type)
        type = type.to_i
        raise ArgumentError, 'invalid damage type' unless DAMAGE_TYPES[type]
        DAMAGE_TYPES[type]
      end

      # Maps an integer-based faction ID to its name
      #
      # @example
      #   >> Armory.faction(0)
      #   => :alliance
      #   >> Armory.faction(1)
      #   => :horde
      # @raise [ArgumentError] Invalid faction
      # @param [Integer] id
      # @return [Symbol]
      def faction(id)
        id = id.to_i
        raise ArgumentError, 'invalid faction' unless FACTIONS[id]
        FACTIONS[id]
      end

      # Maps a single-letter power type to its full name
      #
      # @example
      #   >> Armory.power_type('e')
      #   => :energy
      #   >> Armory.power_type(:m)
      #   => :mana
      # @raise [ArgumentError] Invalid power type
      # @param [String, Symbol] type
      # @return [Symbol]
      def power_type(type)
        type = type.to_sym if type.respond_to? :to_sym
        raise ArgumentError, 'invalid power type' unless POWER_TYPES.keys.include? type
        POWER_TYPES[type]
      end

      # Maps an integer-based quality value to its name
      #
      # @example
      #   >> Armory.quality(4)
      #   => :epic
      #   >> Armory.quality(0)
      #   => :trash
      # @raise [ArgumentError] Invalid quality
      # @param [Integer] id
      # @return [Symbol]
      def quality(id)
        id = id.to_i
        raise ArgumentError, 'invalid quality value' unless QUALITIES[id]
        QUALITIES[id]
      end
    end
  end
end
