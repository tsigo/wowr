module Wowr
  module API
    module ArenaTeams
      def self.included(base)
        base.class_eval do
          @@arena_team_url   = 'team-info.xml'.freeze
          @@arena_team_sizes = [2, 3, 5].freeze

          cattr_accessor :arena_team_url
          cattr_accessor :arena_team_sizes
        end
      end

      # Search for arena teams with the given name of any size.
      # Returns an array of Wowr::Classes::SearchArenaTeam
      # Searches across all realms.
      # Caching is disabled for searching.
      # * name (String) Name of the arena team to seach for
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def search_arena_teams(name, options = {})
        if (name.is_a?(Hash))
          options = name
        else
          options.merge!(:search => name)
        end

        options.merge!(:type => 'arenateams')
        return search(options)
      end

      # Get the arena team of the given name and size, on the specified realm.
      # Returns Wowr::Classes::FullArenaTeam
      # Requires realm.
      # * name (String) Team arena name
      # * size (Fixnum) Must be 2, 3 or 5
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_arena_team(name, size = nil, options = {})
        if name.is_a?(Hash)
          options = name
        elsif size.is_a?(Hash)
          options = size
          options.merge!(:team_name => name)
        else
          options.merge!(:team_name => name, :team_size => size)
        end

        options = merge_defaults(options)

        if options[:team_name].nil? || options[:team_name].empty?
          raise Wowr::Exceptions::ArenaTeamNameNotSet.new
        end

        if options[:realm].nil? || options[:realm].empty?
          raise Wowr::Exceptions::RealmNotSet.new
        end

        unless @@arena_team_sizes.include?(options[:team_size])
          raise Wowr::Exceptions::InvalidArenaTeamSize.new("Arena teams size must be: #{@@arena_team_sizes.inspect}")
        end

        xml = get_xml(@@arena_team_url, options)

        if !(xml%'arenaTeam').nil? and !(xml%'arenaTeam').children.empty?
          return Wowr::Classes::ArenaTeam.new(xml%'arenaTeam')
        else
          raise Wowr::Exceptions::ArenaTeamNotFound.new(options[:team_name])
        end
      end
    end
  end
end
