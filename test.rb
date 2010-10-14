# module Wowr
#   module API
#     module Item
#       def self.included(base)
#         puts "Item included by #{base}"
#         base.send(:include, InstanceMethods)
#       end
# 
#       module InstanceMethods
#         def search_items(q)
#           puts "Wowr::API::Item.search_items #{q}"
#         end
#       end
#     end
#   end
# end
# 
# module Wowr
#   module API
#     def self.new(*args)
#       API.new(args)
#     end
# 
#     class API
#       include Item
# 
#       def initialize(msg)
#         puts "Wowr::API -- #{msg}"
#       end
#     end
#   end
# end
# 
# foo = Wowr::API.new("Hi!")
# foo.search_items("item query")

require 'pp'
require 'wowr'

api = Wowr::API.new
puts api.search_characters('Tsigo').to_yaml
