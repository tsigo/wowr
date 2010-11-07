$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module Guild
      autoload :Base,         'guild/base'
      autoload :Full,         'guild/full'
      autoload :SearchResult, 'guild/search_result'
    end
  end
end
