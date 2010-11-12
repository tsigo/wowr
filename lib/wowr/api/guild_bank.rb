module Wowr
  module API
    module GuildBank
      def self.included(base)
        base.class_eval do
          @@guild_bank_contents_url = 'vault/guild-bank-contents.xml'.freeze
          @@guild_bank_log_url      = 'vault/guild-bank-log.xml'.freeze

          cattr_reader :guild_bank_contents_url
          cattr_reader :guild_bank_log_url
        end
      end

      # Get the current items within the guild bank.
      # Note that the bags and items the user can see is dependent on their privileges.
      # Requires realm.
      # * cookie (String) Cookie data returned by the login function.
      # * guild_name (String) Guild name
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_guild_bank_contents(cookie, name = @guild_name, options = {})
        options = guild_bank_options(cookie, name, options)
        options = merge_defaults(options)

        # FIXME: If cookie's nil, we'll never get here because it will raise an
        # exception in guild_bank_options If it's not nil, it will never be
        # blank, because it's appended to " JSESSIONID=", so why is this here? (tsigo)
        if options[:cookie].nil? || options[:cookie] == ""
          raise Wowr::Exceptions::CookieNotSet.new
        elsif options[:guild_name].nil? || options[:guild_name] == ""
          raise Wowr::Exceptions::GuildNameNotSet.new
        elsif options[:realm].nil? || options[:realm] == ""
          raise Wowr::Exceptions::RealmNotSet.new
        end

        options.merge!(:secure => true)

        xml = get_xml(@@guild_bank_contents_url, options)

        if (xml%'guildBank') and (xml%'guildBank').children.length > 0
          return Wowr::Classes::GuildBankContents.new(xml, self)
        else
          raise Wowr::Exceptions::GuildBankNotFound.new(options[:guild_name])
        end
      end

      # Get a particular page of the guild bank transaction log.
      # Each page contains up to 1000 transactions, other pages can be specified using :group in the options hash.
      # Note that data returned is specific to the logged in user's privileges.
      # Requires realm.
      # * cookie (String) Cookie data returned by the login function
      # * guild_name (String) Guild name
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_guild_bank_log(cookie, name = @guild_name, options = {})
        options = guild_bank_options(cookie, name, options)
        options = merge_defaults(options)

        if options[:cookie].nil? || options[:cookie] == ""
          raise Wowr::Exceptions::CookieNotSet.new
        elsif options[:guild_name].nil? || options[:guild_name] == ""
          raise Wowr::Exceptions::GuildNameNotSet.new
        elsif options[:realm].nil? || options[:realm] == ""
          raise Wowr::Exceptions::RealmNotSet.new
        end

        options.merge!(:secure => true)

        xml = get_xml(@@guild_bank_log_url, options)

        if !(xml%'guildBank').children.empty?
          return Wowr::Classes::GuildBankLog.new(xml, self)
        else
          raise Wowr::Exceptions::GuildBankNotFound.new(options[:guild_name])
        end
      end

      private

      # Normalize the parameters passed to guild bank methods into a Hash
      def guild_bank_options(cookie, name = @guild_name, options = {})
        # FIXME: If cookie is a Hash (below), we're attempting to concatenate a Hash to a string
        # which will just fail. So what are we doing here? (tsigo)
        full_cookie = 'JSESSIONID='+cookie

        if (cookie.is_a?(Hash))
          # FIXME: What the fuck is this? full_cookie will NEVER be a Hash. (tsigo)
          options = full_cookie
        elsif (name.is_a?(Hash))
          options = name
          options.merge!(:cookie => full_cookie)
          options.merge!(:guild_name => name)
        else
          options.merge!(:cookie => full_cookie)
          options.merge!(:guild_name => name)
        end

        options
      end
    end
  end
end
