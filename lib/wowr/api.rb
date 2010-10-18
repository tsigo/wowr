module Wowr
  module API
    # Returns a new instance of Wowr::API::API
    def self.new(options = {})
      # This is basically a hack to let us have a namespace called API without
      # breaking old code which calls API.new(...)
      API.new(options)
    end
  end
end

require 'wowr/api/api'
