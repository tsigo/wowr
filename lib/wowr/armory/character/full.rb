module Wowr
  module Armory
    module Character
      # Full character details with reputations
      class Full < Wowr::Armory::Character::Info
        # Array of {Wowr::Armory::Faction} instances
        # @return [Array]
        attr_reader :reputation

        alias_method :rep, :reputation

        def initialize(sheet, reputation, talents, api = nil)
          @api = api

          # Build the InfoCharacter
          super(sheet, talents, api)

          # Add reputations
          @reputation = []
          (reputation/'faction').each do |faction_elem|
            faction = Faction.new(faction_elem)
            @reputation << faction unless faction.header?
          end
        end

        # @deprecated
        def reputation_categories
          puts "** [DEPRECATED] 'reputation_categories' is deprecated. Use 'reputation' instead."
          reputation
        end
      end
    end
  end
end
