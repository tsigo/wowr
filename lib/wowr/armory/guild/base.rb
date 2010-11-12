module Wowr
  module Armory
    module Guild
      # = Base
      #
      # Shared properties for a <tt>guild</tt> element
      #
      # @abstract
      class Base
        # @return [String]
        attr_reader :name

        # URL parameters
        # @return [String]
        attr_reader :url

        # @return [String]
        attr_reader :realm

        alias_method :to_s, :name

        # @param [Nokogiri::XML::Element] elem
        def initialize(elem)
          # guild-info.xml has a guildHeader element; search doesn't
          if (elem%'guildHeader')
            guild = (elem%'guildHeader')
          else
            guild = elem
          end

          @name  = guild[:name]
          @url   = guild[:url]
          @realm = guild[:realm]
        end
      end
    end
  end
end
