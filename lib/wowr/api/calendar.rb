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

      # @todo Re-implement
      def get_complete_world_calendar(*args)
        raise NotImplementedError, "Calendar methods are temporarily disabled until Armory login can be re-enabled."
      end

      # @todo Re-implement
      def get_world_calendar(*args)
        raise NotImplementedError, "Calendar methods are temporarily disabled until Armory login can be re-enabled."
      end

      # @todo Re-implement
      def get_full_user_calendar(*args)
        raise NotImplementedError, "Calendar methods are temporarily disabled until Armory login can be re-enabled."
      end

      # @todo Re-implement
      def get_user_calendar(*args)
        raise NotImplementedError, "Calendar methods are temporarily disabled until Armory login can be re-enabled."
      end

      # @todo Re-implement
      def get_calendar_event(*args)
        raise NotImplementedError, "Calendar methods are temporarily disabled until Armory login can be re-enabled."
      end
    end
  end
end
