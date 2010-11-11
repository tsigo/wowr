module Wowr
  # = Armory
  #
  # A collection of classes representing XML elements on the Armory
  #
  # Also provides a set of helper methods for dealing with Armory data
  module Armory
    extend self

    QUALITIES = [
      :trash,
      :common,
      :uncommon,
      :rare,
      :epic,
      :legendary,
      :artifact,
      :heirloom
    ]

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
