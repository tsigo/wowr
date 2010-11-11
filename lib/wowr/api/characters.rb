module Wowr
  module API
    module Characters
      def self.included(base)
        base.class_eval do
          @@character_sheet_url        = 'character-sheet.xml'.freeze
          @@character_talents_url      = 'character-talents.xml'.freeze
          @@character_reputation_url   = 'character-reputation.xml'.freeze
          @@character_achievements_url = 'character-achievements.xml'.freeze

          cattr_reader :character_sheet_url
          cattr_reader :character_talents_url
          cattr_reader :character_reputation_url
          cattr_reader :character_achievements_url
        end
      end

      # Returns an array of results of Wowr::Classes::SearchCharacter or an empty array.
      # Searches across all realms.
      # Caching is disabled for searching.
      # Parameters
      # * name (String) Name of the character to search for
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def search_characters(name, options = {})
        if (name.is_a?(Hash))
          options = name
        else
          options.merge!(:search => name)
        end

        options.merge!(:type => 'characters')
        return search(options)
      end

      # Get the full details of a character.
      # Requires realm.
      # * name (String) Name of the character to get, defaults to that specified in constructor
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_character(name = @character_name, options = {})
        options = character_options(name, options)

        character_sheet      = get_xml(@@character_sheet_url,      options)
        character_reputation = get_xml(@@character_reputation_url, options)
        character_talents    = get_xml(@@character_talents_url,    options)

        return Wowr::Classes::FullCharacter.new(character_sheet, character_reputation, character_talents, self)
      end

      # DEPRECATED
      # See get_character
      def get_character_sheet(name = @character_name, options = {})
        return get_character(name, options)
      end

      # Get achievement infos for a character.
      # Requires realm.
      # * name (String) Name of the character to get, defaults to that specified in constructor
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_character_achievements(name = @character_name, options = {})
        options = character_options(name, options)

        character_achievements = get_xml(@@character_achievements_url, options)

        return Wowr::Classes::CharacterAchievementsInfo.new(character_achievements)
      end

      # Get details for all achievements in a category for a character.
      # Requires realm.
      # * achievement_category (Integer) ID of the achievement category
      # * name (String) Name of the character to get, defaults to that specified in constructor
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_character_achievements_category(achievement_category, name = @character_name, options = {})
        options = character_options(name, options)
        options[:achievement_category] = achievement_category.to_i

        character_achievements_category = get_xml(@@character_achievements_url, options)

        return Wowr::Classes::AchievementsList.new(character_achievements_category)
      end

      protected

      # Returns an option array from character_name and defaults
      def character_options(name, options = {})
        if (name.is_a?(Hash))
          options = name
        else
          options.merge!(:character_name => name)

          # TODO check
          # Check what, exactly? (tsigo)
          options = {:character_name => @character_name}.merge(options) if (!@character_name.nil?)
        end

        options = merge_defaults(options)

        if options[:character_name].nil? || options[:chracter_name] == ""
          raise Wowr::Exceptions::CharacterNameNotSet.new
        elsif options[:realm].nil? || options[:realm] == ""
          raise Wowr::Exceptions::RealmNotSet.new
        end

        return options
      end
    end
  end
end
