module Wowr
  module API
    class API
      VERSION = '0.4.1'

      @@search_url = 'search.xml'.freeze
      cattr_reader :search_url

      attr_accessor :character_name, :guild_name, :realm, :lang, :caching, :cache_timeout, :debug

      # @deprecated
      attr_accessor :locale

      include Client

      include ArenaTeams
      include Calendar
      include Characters
      include Dungeons
      include GuildBank
      include Guilds
      include Items

      # @param [Hash] options
      # @option options [String] :character_name
      # @option options [String] :guild_name
      # @option options [String] :realm
      # @option options [String] :lang ('en_US')
      # @option options [Boolean] :caching (true) Enable/Disable caching Armory files to the filesystem
      # @option options [Integer] :cache_timeout (604800) Cache timeout, in seconds
      # @option options [Boolean] :debug (false) Prints out debugging messages during runtime
      def initialize(options = {})
        @character_name = options[:character_name]
        @guild_name     = options[:guild_name]
        @realm          = options[:realm]
        @lang           = options[:lang].nil? ? 'en_US' : options[:lang]
        @caching        = options[:caching].nil? ? true : options[:caching]
        @cache_timeout  = options[:cache_timeout] || (7*24*60*60)
        @debug          = options[:debug] || false
      end

      # General-purpose search
      # All specific searches are wrappers around this method. Best to use those instead.
      # Returns an array of results of the type requested (Wowr::Classes::SearchCharacter etc.) or an empty array.
      # Searches across all realms.
      # Caching is disabled for searching.
      # * string (String) Search string
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def search(string, options = {})
        if (string.is_a?(Hash))
          options = string
        else
          options.merge!(:search => string)
        end

        options = merge_defaults(options)

        if options[:search].nil? || options[:search].empty?
          raise Wowr::Exceptions::NoSearchString.new
        end

        if !valid_search_type?(options[:type])
          raise Wowr::Exceptions::InvalidSearchType.new(options[:type])
        end

        options.merge!(:caching => false)
        options.delete(:realm) # all searches are across realms

        xml = get_xml(@@search_url, options)

        results = []

        if (xml) && (xml%'armorySearch') && (xml%'armorySearch'%'searchResults')
          case options[:type]

          when 'items'
            (xml%'armorySearch'%'searchResults'%'items'/:item).each do |item|
              results << Wowr::Classes::SearchItem.new(item)
            end

          when 'characters'
            (xml%'armorySearch'%'searchResults'%'characters'/:character).each do |char|
              results << Wowr::Classes::SearchCharacter.new(char, self)
            end

          when 'guilds'
            (xml%'armorySearch'%'searchResults'%'guilds'/:guild).each do |guild|
              results << Wowr::Classes::SearchGuild.new(guild)
            end

          when 'arenateams'
            (xml%'armorySearch'%'searchResults'%'arenaTeams'/:arenaTeam).each do |team|
              results << Wowr::Classes::SearchArenaTeam.new(team)
            end
          end
        end

        return results
      end

      private

      # Determines if the given +value+ is a valid search type
      def valid_search_type?(value)
        %w(items characters guilds arenateams).include? value
      end

      # Merge the defaults specified in the constructor with those supplied,
      # overriding any defaults with those supplied
      def merge_defaults(options = {})
        defaults = {}
        # defaults[:character_name] = @charater_name if @charater_name
        # defaults[:guild_name] = @guild_name if @guild_name
        defaults[:realm]          = @realm          if @realm
        defaults[:lang]           = @lang           if @lang
        defaults[:caching]        = @caching        if @caching
        defaults[:cache_timeout]  = @cache_timeout  if @cache_timeout
        defaults[:debug]          = @debug          if @debug

        # overwrite defaults with any given options
        defaults.merge!(options)
      end
    end
  end
end
