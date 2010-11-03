$:.unshift(File.dirname(__FILE__))

module Wowr
  module Classes
    # Represents a money value
    #
    # The total amount can be reduced into gold, silver and copper coin values
    #
    # @example
    #   money = Money.new(5_552_243)
    #   money.gold   # => 555
    #   money.silver # => 22
    #   money.copper # => 43
    #
    # @todo Fix default to_s option
    class Money
      # Total amount of money
      # @return [Integer]
      attr_reader :total

      alias_method :to_i, :total
      alias_method :to_s, :total

      # @param [Integer] total Total amount of money
      def initialize(total)
        @total = total
      end

      # Amount of gold represented by this instance
      # @return [Integer]
      def gold
        return (@total / 10000)
      end

      # Amount of silver represented by this instance
      # @return [Integer]
      def silver
        return (@total % 10000) / 100
      end

      # Amount of copper represented by this instance
      # @return [Integer]
      def copper
        return @total % 100
      end

      # Add one instance to another to form a new total
      # @return [Money]
      def +(amount)
        return Money.new(self.total + amount.total)
      end

      # Subtract one instance from another to form a new total
      # @return [Money]
      def -(amount)
        return Money.new(self.total - amount.total)
      end

      # Older versions of Wowr used "bronze", but all of WoW's
      # interface elements refer to it as "copper"
      alias_method :bronze, :copper
    end
  end
end
