module Wowr
  module Armory
    module Achievement
      # = Completed
      #
      # Represents a <tt>achievement</tt> element with a <tt>dateCompleted</tt> attribute
      #
      # == Relevant XML example:
      #
      #   <achievement categoryId="168" dateCompleted="2010-07-07T21:36:00-05:00"
      #     desc="Defeat Halion in The Ruby Sanctum in 10-player mode." icon="spell_shadow_twilight"
      #     id="4817" points="10" title="The Twilight Destroyer (10 player)"/>
      #
      # @todo I think we should just roll this class into "Base" with a <tt>completed?</tt> method.
      class Completed < Base
        # @param [String|DateTime]
        attr_reader :date_completed

        # @param [Hpricot::Elem] achievement <tt>achievement</tt> element
        def initialize achievement
          super(achievement)

          # Attempt to parse dateCompleted into a DateTime
          begin
            @date_completed = DateTime.parse(achievement[:dateCompleted].to_s)
          rescue ArgumentError
            @date_completed = achievement[:dateCompleted].to_s
          end
        end
      end
    end
  end
end
