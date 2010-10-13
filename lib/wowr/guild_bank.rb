$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'item.rb'
require 'general.rb'

require 'armory/guild_bank/base'
require 'armory/guild_bank/bag'
require 'armory/guild_bank/contents'
require 'armory/guild_bank/item'
require 'armory/guild_bank/log'
require 'armory/guild_bank/log_entry'
require 'armory/guild_bank/log_item'

module Wowr
  module Classes
    class GuildBank         < Wowr::Armory::GuildBank::Base; end
    class GuildBankContents < Wowr::Armory::GuildBank::Contents; end
    class GuildBankLog      < Wowr::Armory::GuildBank::Log; end
    class GuildBankBag      < Wowr::Armory::GuildBank::Bag; end
    class GuildBankLogEntry < Wowr::Armory::GuildBank::LogEntry; end
    class GuildBankLogItem  < Wowr::Armory::GuildBank::LogItem; end
    class GuildBankItem     < Wowr::Armory::GuildBank::Item; end
  end
end
