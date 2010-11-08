module Wowr
  module Armory
    module Character
      # = TalentSpec
      #
      # Represents a <tt>talentGroup</tt> element
      #
      # == Relevant XML example:
      #
      #   <talentGroup active="1" group="2" icon="ability_hunter_focusedaim" prim="Marksmanship">
      #     <talentSpec treeOne="0" treeThree="5" treeTwo="31" value="0000000000000000000230231103212023122103200000000000000000"/>
      #     <glyphs/>
      #   </talentGroup>
      #
      # @todo Rename? It's a Talent Group, not just a Talent Spec
      class TalentSpec
        # An array containing the total points in each tree.
        # @note Tree one is in array index 0, two is in 1, and three is in 2
        # @return [Array]
        attr_reader :trees

        # Whether or not the spec is currently active
        # @return [Boolean]
        attr_reader :active

        # Either the first or second talent spec
        # @return [Integer]
        attr_reader :group

        # The primary tree (i.e., the one with the most points)
        # @example
        #   "Discipline"
        #   "Holy"
        #   "Shadow"
        # @return [String]
        attr_reader :primary

        # The number of points in each talent, left-to-right, top-to-bottom
        # @example No points in the first tree, a majority in the second and five total in the third
        #   "0000000000000000000230231103212023122103200000000000000000"
        # @return [String]
        attr_reader :point_distribution

        # @param [Hpricot::Elem] elem <tt>talentGroup</tt> element
        def initialize(elem)
          tree_elem           = elem%'talentSpec'
          @trees              = []
          @trees[0]           = tree_elem[:treeOne].to_i
          @trees[1]           = tree_elem[:treeTwo].to_i
          @trees[2]           = tree_elem[:treeThree].to_i
          @active             = (elem[:active].to_i == 1 ? true : false)
          @group              = elem[:group].to_i
          @primary            = elem[:prim]
          @point_distribution = tree_elem[:value]
        end
      end
    end
  end
end
