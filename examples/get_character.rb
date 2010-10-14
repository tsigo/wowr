$:.unshift(File.expand_path('../../lib', __FILE__))
require 'wowr'

api = Wowr::API.new(:caching => false)
character = api.get_character('Sebudai', :realm => "Mal'Ganis")

puts character.name
puts "#{character.level} #{character.race} #{character.klass}"
puts character.guild
