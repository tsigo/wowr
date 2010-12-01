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
      #     <glyphs>
      #       <glyph effect="Reduces the focus cost of Trap Launcher by 10." icon="ability_hunter_traplauncher" id="353" name="Glyph of Trap Launcher" type="major"/>
      #       <glyph effect="Increases the range of your Aspect of the Pack ability by 15 yards." icon="ability_mount_whitetiger" id="443" name="Glyph of Aspect of the Pack" type="minor"/>
      #       <glyph effect="Your Mend Pet spell increases your pet's happiness slightly." icon="ability_hunter_mendpet" id="440" name="Glyph of Mend Pet" type="minor"/>
      #       <glyph effect="Decreases the cooldown of Disengage by 5 sec." icon="ability_rogue_feint" id="358" name="Glyph of Disengage" type="major"/>
      #       <glyph effect="Reduces the cooldown of your Feign Death spell by 5 sec." icon="ability_rogue_feigndeath" id="441" name="Glyph of Feign Death" type="minor"/>
      #       <glyph effect="Increases the total amount of healing done by your Mend Pet ability by 60%." icon="ability_hunter_mendpet" id="354" name="Glyph of Mending" type="major"/>
      #       <glyph effect="Increases the damage dealt by Steady Shot by 10%." icon="ability_hunter_steadyshot" id="368" name="Glyph of Steady Shot" type="prime"/>
      #       <glyph effect="Your Arcane Shot deals 12% more damage." icon="ability_impalingbolt" id="352" name="Glyph of Arcane Shot" type="prime"/>
      #       <glyph effect="If the damage from your Kill Shot fails to kill a target at or below 20% health, your Kill Shot's cooldown is instantly reset. This effect has a 6 sec cooldown." icon="ability_hunter_assassinate2" id="692" name="Glyph of Kill Shot" type="prime"/>
      #     </glyphs>
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

        # An array containing the glyphs in each tree.
        # @return [Array]
        attr_reader :glyphs

        # @param [Nokogiri::XML::Element] elem <tt>talentGroup</tt> element
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

          @glyphs = elem.search('glyph').collect { |g| Wowr::Armory::Item::Glyph.new(g) }
        end
      end
    end
  end
end
