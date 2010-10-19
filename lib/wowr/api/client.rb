require 'cgi'

module Wowr
  module API
    module Client
      def self.included(base)
        base.class_eval do
          @@armory_base_url   = 'wowarmory.com/'
          @@login_base_url    = 'battle.net/'
          @@login_url         = 'login/login.xml'
          @@persistent_cookie = 'COM-warcraft'
          @@temporary_cookie  = 'JSESSIONID'

          @@max_connection_tries = 10
          @@user_agent           = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10'

          @@cache_directory_path  = 'cache/'
          @@default_cache_timeout = (7*24*60*60)
          @@failed_cache_timeout  = (60*60*24)
          @@cache_failed_requests = true # cache requests that resulted in an error from the armory

          cattr_accessor :armory_base_url
          cattr_accessor :login_base_url
          cattr_accessor :login_url
          cattr_accessor :persistent_cookie
          cattr_accessor :temporary_cookie

          cattr_accessor :max_connection_tries
          cattr_accessor :user_agent

          cattr_accessor :cache_directory_path
          cattr_accessor :default_cache_timeout
          cattr_accessor :failed_cache_timeout
          cattr_accessor :cache_failed_requests
        end
      end

      # Return the base url for the armory, e.g. http://eu.wowarmory.com/
      # * locale (String) The locale, defaults to that specified in the API constructor
      def base_url(locale = @locale, options = {})
        str = ""

        if (options[:secure] == true)
          str += 'https://'
        else
          str += 'http://'
        end

        if (locale == 'us')
          str += 'www.'
        else
          str += locale + "."
        end

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
        raw_json = response.scan(/\w+\((.+)\);\z/)[0][0]
        return JSON.parse(raw_json)
      end

      # Perform an HTTP request and return the contents of the document
      def http_request(url, options = {})
        req = Net::HTTP::Get.new(url)
        req["user-agent"] = @@user_agent # ensure returns XML
        req["cookie"] = "cookieMenu=all; cookieLangId=" + options[:lang] + "; cookies=true;"

        req["cookie"] += options[:cookie] if options[:cookie]

        uri = URI.parse(URI.escape(url))

        http = Net::HTTP.new(uri.host, uri.port)

        if (options[:secure])
          puts "Secure authentication" if options[:debug]

          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          http.use_ssl = true
        end

        begin
          tries = 0
          http.start do
            puts "Get URL "+ url if options[:debug]
            res = http.request req
            # response = res.body

            response = case res
                       when Net::HTTPSuccess, Net::HTTPRedirection
                         res.body
                       when Net::HTTPInternalServerError
                         # TODO: Better handling of standard Armory server errors? (tsigo)
                         res.body
                       else
                         tries += 1
                         if tries > @@max_connection_tries
                           raise Wowr::Exceptions::NetworkTimeout.new('Timed out')
                         else
                           redo
                         end
                       end
          end
        rescue Timeout::Error => e
          raise Wowr::Exceptions::NetworkTimeout.new('Timed out - Timeout::Error Exception')
        rescue SocketError, Net::HTTPExceptions => e
          raise Wowr::Exceptions::ServerDoesNotExist.new('Specified server at ' + url + ' does not exist.')
        end
      end

      # Return an raw document for the given URL
      # TODO: Tidy up?
      def get_file(url, options = {})

        # better way of doing this?
        # Map custom keys to the HTTP request values
        # TODO add handles for searching based upon stats
        reqs = {
          :character_name => 'n',
          :source => "fl[source]", # dungeon, badges, arena, etc
          :dungeon => "fl[dungeon]", # seems it needs the dungeons id rather than name
          :difficulty => "fl[difficulty]", # normal, heroic, etc
          :item_type => "fl[type]", # weapon, armor, trinket, etc
          :item_slot => "fl[slot]", # head, shoulders, etc
          :item_sub_type => "fl[subTp]", # leather, mail, etc
          :realm => 'r',
          :search => 'searchQuery',
          :type => 'searchType',
          :guild_name => 'gn',
          :item_id => 'i',
          :team_size => 'ts',
          :team_name => 't',
          :group => 'group',
          :callback => 'callback',
          :calendar_type => 'type',
          :month => 'month',
          :year => 'year',
          :event => 'e',
          :now => 'now',
          :achievement_category => 'c'
        }

        params = []
        options.each do |key, value|
          params << "#{reqs[key]}=#{escape(value)}" if reqs[key]
        end

        query = ''
        query = query + '?' + params.join('&') if params.size > 0
        #query = '?' + params.join('&') if params.size > 0

        base = self.base_url(options[:locale], options)
        full_query = base + url + query

        if options[:caching]
          response = get_cache(full_query, options)
        else
          response = http_request(full_query, options)
        end
      end

      # remove http://*.wowarmory.com/ leaving just xml file part and request parameters
      # Kind of assuming incoming URL is the same as the current locale
      def url_to_filename(url) #:nodoc:
        temp = url.gsub(base_url(), '')
        temp.gsub!('/', '.')
        return temp
      end

      def localised_cache_path(lang = @lang) #:nodoc:
        return @@cache_directory_path + lang
      end

      # Translate the specified URL to the cache location, and return the file
      # If the cache does not exist, get the contents using http_request and create it
      def get_cache(url, options = {})
        path = cache_path(url, options)

        # file doesn't exist, make it
        if !File.exists?(path) ||
          options[:refresh_cache] ||
          (File.mtime(path) < Time.now - @cache_timeout)

          if options[:debug]
            if !File.exists?(path)
              puts 'Cache doesn\'t exist, making: ' + path
            elsif (File.mtime(path) < Time.now - @cache_timeout)
              puts 'Cache has expired, making again, making: ' + path
            elsif options[:refresh_cache]
              puts 'Forced refresh of cache, making: ' + path
            end
          end

          # make sure dir exists
          FileUtils.mkdir_p(localised_cache_path(options[:lang])) unless File.directory?(localised_cache_path(options[:lang]))

          xml_content = http_request(url, options)

          # write the cache
          file = File.open(path, File::WRONLY|File::TRUNC|File::CREAT)
          file.write(xml_content)
          file.close

        # file exists, return the contents
        else
          puts 'Cache already exists, read: ' + path if options[:debug]

          file = File.open(path, 'r')
          xml_content = file.read
          file.close
        end
        return xml_content
      end

      def cache_path(url, options)
        @@cache_directory_path + options[:lang] + '/' + url_to_filename(url)
      end

      private

      def escape(str) #:nodoc:
        if str.instance_of?(String)
          return CGI.escape(str)
        else
          return str
        end
      end
    end
  end
end
