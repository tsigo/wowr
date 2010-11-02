require 'cgi'

module Wowr
  module API
    # @todo Move to separate file
    module ArmoryClient
      include HTTParty
      include HTTParty::Icebox

      headers 'User-Agent' => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10'
    end
  end
end

module Wowr
  module API
    module Client
      def self.included(base)
        base.class_eval do
          @@armory_base_url   = 'wowarmory.com/'.freeze
          @@login_base_url    = 'battle.net/'.freeze
          @@login_url         = 'login/login.xml'.freeze
          @@persistent_cookie = 'COM-warcraft'.freeze
          @@temporary_cookie  = 'JSESSIONID'.freeze

          @@max_connection_tries = 10.freeze

          @@cache_directory_path  = 'cache/'
          @@default_cache_timeout = (7*24*60*60)
          @@failed_cache_timeout  = (60*60*24)
          @@cache_failed_requests = true

          cattr_reader :armory_base_url
          cattr_reader :login_base_url
          cattr_reader :login_url
          cattr_reader :persistent_cookie
          cattr_reader :temporary_cookie

          cattr_reader :max_connection_tries

          cattr_accessor :cache_directory_path
          cattr_accessor :default_cache_timeout
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

      # Logs the user into the armory using their main world of warcraft username, password and authenticator if given/required.
      # Uses SSL to send details to the login page. Both must be set to true in order to recieve the long life cookie as the second value.
      #
      # short = api.login("username", "password")
      # short, long = api.login("username", "password", nil, true)
      #
      # TODO: Use HTTParty
      def login(username, password, authenticator = nil, both = false)
        # Create the base URL we will be POSTing to.
        authentication_url = base_url(@locale, {:secure => true, :login => true}) + @@login_url + "?app=armory"

        # Ensure we add the correct bounce point.
        if (@locale == "www")
          authentication_url += "&ref=http://www.wowarmory.com/index.xml"
        else
          authentication_url += "&ref=http://#{@locale}.wowarmory.com/index.xml"
        end

        # Ensure we have no final stage.
        redirectstage = nil

        # Post the first stage
        stage1 = login_http(authentication_url, true, nil, { 'accountName' => username, 'password' => password }, true)

        # Check what happened.
        if (stage1.code == "200")
          # We didn't pass, but we didn't fail yet if we need an authenticator.
          stage1doc = Hpricot.XML(stage1.body)

          # Check to see if our details were incorrect.
          if (stage1doc.at("tas:accountName")['error'])
            # We have had an error returned to us with regards to our username or password.
            raise Wowr::Exceptions::InvalidLoginDetails
          end

          # Okey do we require an authenticator?
          if (!stage1doc.at("tas:authType")['value'] || stage1doc.at("tas:authType")['value'] != "BA")
            # Ummm, we're not invalid nor do we have no clue about the authType required now.
            raise Wowr::Exceptions::LoginBroken
          end

          # Do we have an authenticator code to use?
          raise Wowr::Exceptions::LoginRequiresAuthenticator if (!authenticator)

          stage1cookie = nil

          # Get the *authentication sites* JSESSIONID.
          stage1.header['set-cookie'].scan(/JSESSIONID=(.*?);/) {
            stage1cookie = $1
          }

          # Let's post the authenticator and the session for this login.
          stage2 = login_http(authentication_url, true, { 'JSESSIONID' => stage1cookie }, { 'authValue' => authenticator }, true)

          # So now we check what happened.
          if (stage2.code == "200")
            # This isn't a good sign, we should have redirected now.
            stage2doc = Hpricot.XML(stage2.body)

            # Error is obvious
            if (stage2doc.at("tas:accountName")['error'])
              # We have had an error returned to us with regards to our username or password.
              raise Wowr::Exceptions::InvalidLoginDetails
            end

            # Error isn't obvious, we can't continue.
            raise Wowr::Exceptions::LoginBroken
          elsif (stage2.code == "302")
            redirectstage = stage2
          end
        elsif (stage1.code == "302")
          redirectstage = stage1
        end

        # We should have been redirected by now.
        if (!redirectstage)
          raise Wowr::Exceptions::LoginBroken
        end

        # Time to obtain our next URL and our long term cookie.
        long_cookie = nil

        redirectstage.header['set-cookie'].scan(/#{@@persistent_cookie}=(.*?);/) {
          long_cookie = $1
        }

        # Let's bounce to our page that will give us our short term cookie, URL has Kerbrose style ticket.
        short_cookie = login_final_bounce(redirectstage.header['location'])

        # So what does the user want?
        if (both)
          return short_cookie, long_cookie
        else
          return short_cookie
        end
      end

      # Reobtains a short term cookie by using the given long life cookie.
      # TODO: Use HTTParty
      def refresh_login(long_life_cookie)
        # Create the base URL we will be POSTing to.
        authentication_url = base_url(@locale, {:secure => true, :login => true}) + @@login_url + "?app=armory"

        # Ensure we add the correct bounce point.
        if (@locale == "www")
          authentication_url += "&ref=http://www.wowarmory.com/index.xml"
        else
          authentication_url += "&ref=http://#{@locale}.wowarmory.com/index.xml"
        end

        # All we need to do is goto the armory login page passing our long life cookie, we should get 302 instantly.
        stage1 = login_http(authentication_url, true, { @@persistent_cookie => long_life_cookie })

        # Let's see
        if (stage1.code == "200")
          # It's no good, our cookie doesn't work anymore.
          raise Wowr::Exceptions::InvalidLoginDetails
        elsif (stage1.code == "302")
          # Let's bounce to our page that will give us our short term cookie, URL has Kerbrose style ticket.
          return login_final_bounce(stage1.header['location'])
        end

        # Finally we didn't get 302 or 200?
        raise Wowr::Exceptions::LoginBroken
      end

      protected

      # TODO: Use HTTParty
      def login_final_bounce(url)
        # Let's bounce to our page that will give us our short term cookie, URL has Kerbrose style ticket.
        finalstage = login_http(url)

        # Did we get a 200?
        if (finalstage.code == "200")
          # Get the short term cookie at last
          short_cookie = nil
          finalstage.header['set-cookie'].scan(/#{@@temporary_cookie}=(.*?);/) {
            short_cookie = $1
          }

          return short_cookie
        end

        # Finally we didn't get 200?
        raise Wowr::Exceptions::LoginBroken
      end

      # TODO: Use HTTParty
      def login_http(url, ssl = false, cookie = nil, data = nil, post = false)
        if (post)
          req = Net::HTTP::Post.new(url)
        else
          req = Net::HTTP::Get.new(url)
        end

        req["user-agent"] = "Mozilla/5.0 Gecko/20070219 Firefox/2.0.0.2" # ensure returns XML
        req["cookie"] = "cookieMenu=all; cookies=true;"
        req["cookie"] += cookie.collect { |key, value| "#{key}=#{value};"}.join(" ") if cookie

        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)

        if (ssl)
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          http.use_ssl = true
        end

        req.set_form_data(data, '&') if data

        http.start do
          res = http.request(req)

          tries = 0
          response = case res
                     when Net::HTTPSuccess, Net::HTTPRedirection
                       return res
                     else
                       tries += 1
                       if tries > @@max_connection_tries
                         raise Wowr::Exceptions::NetworkTimeout.new('Timed out')
                       else
                         redo
                       end
                     end
        end
      end

      # TODO: moved parsing out of get_xml, maybe add Nokogiri faster than Hpricot?
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

      # Return a raw document for the given URL
      # TODO: Tidy up?
      def get_file(url, options = {})
        query = remap_parameters(options)

        client = ArmoryClient
        client.base_uri(self.base_url(options) + "/")
        client.cookies("cookieLangId" => options[:lang])

        if options[:caching]
          client.cache :store => 'file', :timeout => @cache_timeout, :location => @@cache_directory_path
        else
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
      #   >> options = {:character_name => 'Tsigo', :realm => "Mal'Ganis"}
      #   >> puts remap_parameters(options)
      #   => {:cn => "Tsigo", :r => "Mal'Ganis"}
      # @param [Hash] options Options hash
      def remap_parameters(options = {})
        # Map verbose option keys to the parameter keys used by the Armory
        # For example, ":character_name" becomes "cn"
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
