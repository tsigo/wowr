module Wowr
  module Armory
    module Item
      # <item requiredSkill="Jewelcrafting" name="Design: Bracing Earthstorm Diamond" icon="inv_scroll_03" type="Jewelcrafting" level="73" id="25903" requiredSkillRank="365" quality="1"></item>
      class Plan < Wowr::Armory::Item::Base
        attr_reader :required_skill, :type, :required_skill_rank, :level, :quality

        def initialize(elem, api = nil)
          super(elem, api)
          @type = elem[:type]
          @level = elem[:level].to_i
          @quality = elem[:quality].to_i
          @required_skill = elem[:requiredSkill]
          @required_skill_rank = elem[:requiredSkillRank].to_i
        end
      end
    end
  end
end
