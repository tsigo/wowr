module Wowr
  module Armory
    module Item
      # Creatures that drop the item
      # <creature name="Giant Marsh Frog" minLevel="1" type="Critter" maxLevel="1" dropRate="6" id="23979" classification="0" area="Dustwallow Marsh"></creature>
      # <creature name="Nalorakk" minLevel="73" title="Bear Avatar" url="fl[source]=dungeon&amp;fl[difficulty]=normal&amp;fl[boss]=23576" type="Humanoid" maxLevel="73" dropRate="2" id="23576" classification="3" areaUrl="fl[source]=dungeon&amp;fl[boss]=all&amp;fl[difficulty]=normal&amp;fl[dungeon]=3805" area="Zul'Aman"></creature>
      class DropCreature
        attr_reader :name, :id, :type, :min_level, :max_level, :drop_rate, :classification, :area

        def initialize(elem)
          @name           = elem[:name]
          @id             = elem[:id].to_i
          @min_level      = elem[:minLevel].to_i
          @max_level      = elem[:maxLevel].to_i
          @drop_rate      = elem[:dropRate].to_i
          @classification = elem[:classification].to_i
          @area           = elem[:area]

          # optional boss stuff
          @title    = elem[:title]    if elem[:title] # TODO: not nil when no property?
          @url      = elem[:url]      if elem[:url]
          @type     = elem[:type]     if elem[:type] # Humanoid etc.
          @area_url = elem[:areaUrl]  if elem[:areaUrl]
        end
      end
    end
  end
end
