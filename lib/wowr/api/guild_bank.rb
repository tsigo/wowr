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

      # @todo Re-implement
      def get_guild_bank_contents(*args)
        raise NotImplementedError, "Guild bank methods are temporarily disabled until Armory login can be re-enabled."
      end

      # @todo Re-implement
      def get_guild_bank_log(*args)
        raise NotImplementedError, "Guild bank methods are temporarily disabled until Armory login can be re-enabled."
      end
    end
  end
end
