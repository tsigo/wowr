module Wowr
  module API
    module Client
      # = ArmoryClient
      #
      # HTTParty class for making requests to the Armory
      class ArmoryClient
        include HTTParty
        include HTTParty::Icebox

        headers 'User-Agent' => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10'
      end

      def self.included(base)
        base.class_eval do
          @@armory_base_url   = 'wowarmory.com/'.freeze
          @@login_base_url    = 'battle.net/'.freeze
          @@login_url         = 'login/login.xml'.freeze
          @@persistent_cookie = 'COM-warcraft'.freeze
          @@temporary_cookie  = 'JSESSIONID'.freeze

          @@max_connection_tries = 10.freeze

          @@cache_directory_path  = 'cache/'
          @@failed_cache_timeout  = (60*60*24)
          @@cache_failed_requests = true

          cattr_reader :armory_base_url
          cattr_reader :login_base_url
          cattr_reader :login_url
          cattr_reader :persistent_cookie
          cattr_reader :temporary_cookie

          cattr_reader :max_connection_tries

          cattr_accessor :cache_directory_path
          cattr_accessor :failed_cache_timeout
          cattr_accessor :cache_failed_requests
        end
      end

      # Return the base url for the armory, e.g. http://eu.wowarmory.com/
      # * locale (String) The locale, defaults to that specified in the API constructor
      def base_url(options = {})
        str = ""

        if (options[:secure] == true)
          str += 'https://'
        else
          str += 'http://'
        end

        # No more language-specific subdomains
        # Language is handled in a cookie
        str += "www."

        if (options[:login] == true)
          str += @@login_base_url
        else
          str += @@armory_base_url
        end

        return str
      end

      # @todo Re-implement
      def login(*args)
        raise NotImplementedError, "Logging into the Armory through Wowr is currently broken."
      end

      # @todo Re-implement?
      def refresh_login(*args)
        raise NotImplementedError, "Logging into the Armory through Wowr is currently broken."
      end

      protected

      def parser(response, options = {})
        doc = Hpricot.XML(response)
        errors = doc.search("*[@errCode]")
        if errors.size > 0
          errors.each do |error|
            raise Wowr::Exceptions::raise_me(error[:errCode], options)
          end
        elsif (doc%'achievements')
          return doc
        elsif (doc%'dungeons')
          return doc
        elsif (doc%'page').nil?
          raise Wowr::Exceptions::EmptyPage
        else
          return (doc%'page')
        end
      end

      # Return an Hpricot document for the given URL, TODO: see :parser
      def get_xml(url, options = {})
        response = get_file(url, options)
        parser(response, options)
      end

      # Return an array of hashes for the given URL
      def get_json(url, options = {})
        response = get_file(url, options)
        JSON.parse(response)
      end

      # Given a url and a hash of query parameters, fetches a file from the Armory as raw XML
      def get_file(url, options = {})
        query = remap_parameters(options)

        client = ArmoryClient
        client.base_uri(self.base_url(options) + "/")
        client.cookies("cookieLangId" => options[:lang])

        if options[:caching]
          client.cache :store => 'file', :timeout => @cache_timeout, :location => @@cache_directory_path
        else
          # Default setting
          client.cache :store => 'memory', :timeout => 60
        end

        begin
          client.get(url, :query => query).response.body
        rescue Timeout::Error => e
          raise Wowr::Exceptions::NetworkTimeout.new('Timed out - Timeout::Error Exception')
        rescue SocketError, Net::HTTPExceptions => e
          raise Wowr::Exceptions::ServerDoesNotExist.new('Specified server at ' + url + ' does not exist.')
        end
      end

      private

      # Remap verbose option keys to the parameter keys used by the Armory
      #
      # @example
      #   >> remap_parameters(:character_name => 'Tsigo', :realm => "Mal'Ganis", :guild_name => 'Juggernaut')
      #   => {:cn => "Tsigo", :r => "Mal'Ganis", :gn => "Juggernaut"}
      # @param [Hash] options Options hash
      def remap_parameters(options = {})
        @option_map ||= {
          :character_name       => 'cn',
          :source               => "fl[source]",     # dungeon, badges, arena, etc
          :dungeon              => "fl[dungeon]",    # seems it needs the dungeons id rather than name
          :difficulty           => "fl[difficulty]", # normal, heroic, etc
          :item_type            => "fl[type]",       # weapon, armor, trinket, etc
          :item_slot            => "fl[slot]",       # head, shoulders, etc
          :item_sub_type        => "fl[subTp]",      # leather, mail, etc
          :realm                => 'r',
          :search               => 'searchQuery',
          :type                 => 'searchType',
          :guild_name           => 'gn',
          :item_id              => 'i',
          :team_size            => 'ts',
          :team_name            => 't',
          :group                => 'group',
          :callback             => 'callback',
          :calendar_type        => 'type',
          :month                => 'month',
          :year                 => 'year',
          :event                => 'e',
          :now                  => 'now',
          :achievement_category => 'c'
        }

        query = {}
        options.each do |key, value|
          query.merge!(@option_map[key] => value) if @option_map[key]
        end

        query
      end
    end
  end
end
