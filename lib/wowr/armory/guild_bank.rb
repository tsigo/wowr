$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module GuildBank
      autoload :Bag,      'guild_bank/bag'
      autoload :Base,     'guild_bank/base'
      autoload :Contents, 'guild_bank/contents'
      autoload :Item,     'guild_bank/item'
      autoload :Log,      'guild_bank/log'
      autoload :LogEntry, 'guild_bank/log_entry'
      autoload :LogItem,  'guild_bank/log_item'
    end
  end
end
