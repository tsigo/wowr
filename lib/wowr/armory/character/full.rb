module Wowr
  module Armory
    module Character
      # Full character details with reputations
      class Full < Wowr::Armory::Character::Info
        attr_reader :reputation_categories

        alias_method :rep, :reputation_categories
        alias_method :reputation, :reputation_categories

        def initialize(sheet, reputation, talents, api = nil)
          @api = api

          # Build the InfoCharacter
          super(sheet, talents, api)

          # Add reputations
          character_reputation(reputation)
        end

        # character-reputation.xml
        def character_reputation(elem)
          @reputation_categories = {}
          (elem/:factionCategory).each do |category|
            @reputation_categories[category[:key]] = RepFactionCategory.new(category)
          end
        end
      end
    end
  end
end
