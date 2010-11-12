module Wowr
  module API
    module Calendar
      def self.included(base)
        base.class_eval do
          @@calendar_user_url   = 'vault/calendar/month-user.json'.freeze
          @@calendar_world_url  = 'vault/calendar/month-world.json'.freeze
          @@calendar_detail_url = 'vault/calendar/detail.json'.freeze

          @@calendar_world_types = %w(player holiday bg darkmoon raidLockout raidReset holidayWeekly).freeze
          @@calendar_user_types = %w(raid dungeon pvp meeting other).freeze

          cattr_reader :calendar_user_url
          cattr_reader :calendar_world_url
          cattr_reader :calendar_detail_url
        end
      end

      def get_complete_world_calendar(cookie, name = @character_name, realm = @realm, options = {})
        options = calendar_options(cookie, event, name, realm, options)
        options = merge_defaults(options)

        events = []

        @@calendar_world_types.each do |type|
          options.merge!(:calendar_type => type)
          events = events.concat(get_world_calendar(options))
        end

        events.sort! { |a,b| a.start <=> b.start }

        return events
      end

      def get_world_calendar(cookie, name = @character_name, realm = @realm, options = {})
        options = calendar_options(cookie, event, name, realm, options)
        options = merge_defaults(options)

        if options[:cookie].nil? || options[:cookie] == ""
          raise Wowr::Exceptions::CookieNotSet.new
        elsif options[:character_name].nil? || options[:guild_name] == ""
          raise Wowr::Exceptions::CharacterNameNotSet.new
        elsif options[:realm].nil? || options[:realm] == ""
          raise Wowr::Exceptions::RealmNotSet.new
        end

        options.merge!(:secure => true)

        json = get_json(@@calendar_world_url, options)

        if (!json["events"])
          raise Wowr::Exceptions::EmptyPage
        end

        events = []

        json["events"].each do |event|
          events << Wowr::Classes::WorldCalendar.new(event, nil)
        end

        return events
      end

      def get_full_user_calendar(cookie, name = @character_name, realm = @realm, options = {})
        options = calendar_options(cookie, event, name, realm, options)
        options = merge_defaults(options)

        skel_events = get_user_calendar(options)
        full_events = []

        skel_events.each do |se|
          options.merge!(:event => se.id)
          full_events << get_calendar_event(options)
        end

        full_events.sort! { |a,b| a.start <=> b.start }

        return full_events
      end

      def get_user_calendar(cookie, name = @character_name, realm = @realm, options = {})
        options = calendar_options(cookie, event, name, realm, options)
        options = merge_defaults(options)

        if options[:cookie].nil? || options[:cookie] == ""
          raise Wowr::Exceptions::CookieNotSet.new
        elsif options[:character_name].nil? || options[:guild_name] == ""
          raise Wowr::Exceptions::CharacterNameNotSet.new
        elsif options[:realm].nil? || options[:realm] == ""
          raise Wowr::Exceptions::RealmNotSet.new
        end

        options.merge!(:secure => true)

        json = get_json(@@calendar_user_url, options)

        if (!json["events"])
          raise Wowr::Exceptions::EmptyPage
        end

        events = []

        json["events"].each do |event|
          events << Wowr::Classes::UserCalendar.new(event, nil)
        end

        return events
      end

      def get_calendar_event (cookie, event = nil, name = @character_name, realm = @realm, options = {})
        options = calendar_options(cookie, event, name, realm, options)
        options = merge_defaults(options)

        if options[:cookie].nil? || options[:cookie] == ""
          raise Wowr::Exceptions::CookieNotSet.new
        elsif options[:character_name].nil? || options[:guild_name] == ""
          raise Wowr::Exceptions::CharacterNameNotSet.new
        elsif options[:realm].nil? || options[:realm] == ""
          raise Wowr::Exceptions::RealmNotSet.new
        elsif options[:event].nil? || options[:event] == ""
          raise Wowr::Exceptions::EventNotSet.new
        end

        options.merge!(:secure => true)

        json = get_json(@@calendar_detail_url, options)

        if (!json.is_a?(Hash))
          raise Wowr::Exceptions::EmptyPage
        end

        return Wowr::Classes::UserDetailCalendar.new(json, nil)
      end

      private

      # Normalize the parameters passed to calendar methods into a Hash
      def calendar_options(cookie, event = nil, name = @character_name, realm = @realm, options = {})
        # FIXME: If cookie is a Hash (below), we're attempting to concatenate a Hash to a string
        # which will just fail. So what are we doing here? (tsigo)
        full_cookie = ' JSESSIONID='+cookie

        if (cookie.is_a?(Hash))
          # FIXME: What the fuck is this? full_cookie will NEVER be a Hash. (tsigo)
          options = full_cookie
        elsif (name.is_a?(Hash))
          options = name
          options.merge!(:cookie => full_cookie)
          options.merge!(:character_name => @character_name)
          options.merge!(:realm => @realm)
        elsif (realm.is_a?(Hash))
          options = realm
          options.merge!(:cookie => full_cookie)
          options.merge!(:character_name => name)
          options.merge!(:realm => @realm)
        else
          options.merge!(:cookie => full_cookie)
          options.merge!(:character_name => name)
          options.merge!(:realm => realm)
        end

        options
      end
    end
  end
end
