module Wowr
  module Armory
    module Character
      # Note the list of talent trees starts at 1. This is quirky, but that's what's used in the XML
      class TalentSpec
        attr_reader :trees, :active, :group, :primary, :point_distribution

        def initialize(elem)
          tree_elem = elem%'talentSpec'
          @trees = []
          @trees[0] = tree_elem[:treeOne].to_i
          @trees[1] = tree_elem[:treeTwo].to_i
          @trees[2] = tree_elem[:treeThree].to_i
          @active = (elem[:active].to_i == 1 ? true : false)
          @group = elem[:group].to_i
          @primary = elem[:prim]
          @point_distribution = tree_elem[:value]
        end
      end
    end
  end
end
