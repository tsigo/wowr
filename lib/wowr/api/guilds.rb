module Wowr
  module API
    module Guilds
      def self.included(base)
        base.class_eval do
          @@guild_info_url    = 'guild-info.xml'

          cattr_accessor :guild_info_url
        end
      end

      # Find all guilds with the given string, return array of Wowr::Classes::SearchGuild.
      # Searches across all realms.
      # Caching is disabled for searching.
      # * name (String) Name of the guild to search for
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def search_guilds(name, options = {})
        if (name.is_a?(Hash))
          options = name
        else
          options.merge!(:search => name)
        end
        options.delete(:realm)

        options.merge!(:type => 'guilds')
        return search(options)
      end

      # Get the guild details.
      # Guild name is optional, assuming it's set in the api constructor.
      # Requires realm.
      # * name (String) Name of the guild to retrieve, defaults to that specified in constructor
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_guild(name = @guild_name, options = {})
        if (name.is_a?(Hash))
          options = name
        else
          options.merge!(:guild_name => name)
        end

        options = merge_defaults(options)

        if options[:guild_name].nil? || options[:guild_name] == ""
          raise Wowr::Exceptions::GuildNameNotSet.new
        elsif options[:realm].nil? || options[:realm].empty?
          raise Wowr::Exceptions::RealmNotSet.new
        end

        xml = get_xml(@@guild_info_url, options)

        if !(xml%'guildInfo').nil? and !(xml%'guildInfo').children.empty?
          return Wowr::Classes::FullGuild.new(xml)
        else
          raise Wowr::Exceptions::GuildNotFound.new(options[:guild_name])
        end
      end
    end
  end
end
