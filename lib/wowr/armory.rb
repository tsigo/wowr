module Wowr
  # = Armory
  #
  # A collection of classes representing XML elements on the Armory
  #
  # Also provides a set of helper methods for dealing with Armory data
  module Armory
    extend self

    # @see #damage_type
    DAMAGE_TYPES = [:physical, :holy, :fire, :nature, :frost, :shadow, :arcane].freeze

    # @see #quality
    QUALITIES = [:trash, :common, :uncommon, :rare, :epic, :legendary, :artifact, :heirloom].freeze

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

      raise ArgumentError, 'invalid damage type' unless (0..6).include? type

      DAMAGE_TYPES[type]
    end

    # Maps an integer-based quality value to its name
    #
    # @example
    #   >> Armory.quality(4)
    #   => :epic
    #   >> Armory.quality(0)
    #   => :trash
    # @raise [ArgumentError] Invalid quality
    # @param [Integer] quality
    # @return [Symbol]
    def quality(quality)
      quality = quality.to_i

      raise ArgumentError, 'invalid quality value' unless (0..7).include? quality

      QUALITIES[quality]
    end
  end
end
