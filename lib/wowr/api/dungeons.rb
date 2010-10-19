module Wowr
  module API
    module Dungeons
      def self.included(base)
        base.class_eval do
          @@dungeons_url         = '_data/dungeons.xml'
          @@dungeons_strings_url = 'data/dungeonStrings.xml'

          cattr_accessor :dungeons_url
          cattr_accessor :dungeons_strings_url
        end
      end

      # Get complete list of dungeons.
      # WARNING: This gets two 6k xml files so it's not that fast
      # Takes 0.2s with cache, 2s without
      # New approach: Instead of passing the XML around and performing multiple
      # search lookups to find the elements, run through each XML file once
      # adding data to classes as they appear using hash lookup.
      # Went from 14s to 2s :)
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_dungeons(options = {})
        options = merge_defaults(options)

        # dungeon_strings contains names for ids
        dungeon_xml = get_xml(@@dungeons_url, options)%'dungeons'

        dungeon_strings_xml = get_xml(@@dungeons_strings_url, options)

        results = {}

        # TODO: Pass the correct part of dungeon_strings_xml to each dungeon?
        if dungeon_xml && !dungeon_xml.children.empty?
          (dungeon_xml/:dungeon).each do |elem|
            dungeon = Wowr::Classes::Dungeon.new(elem)
            results[dungeon.id] = dungeon   if dungeon.id
            results[dungeon.key] = dungeon  if dungeon.key
          end

          (dungeon_strings_xml/:dungeon).each do |elem|
            id = elem[:id].to_i
            key = elem[:key]

            if (results[id])
              results[id].add_name_data(elem)
            elsif (results[key])
              results[key].add_name_data(elem)
            end
          end
        else
          raise Wowr::Exceptions::InvalidXML.new()
        end

        return results
      end
    end
  end
end
