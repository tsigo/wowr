# Wowr - Ruby library for the World of Warcraft Armory
# http://wowr.rubyforge.org/

# written by Ben Humphreys,
# since he gave up WoW :)
# http://benhumphreys.co.uk/

begin
	require 'hpricot' # version 0.6
rescue LoadError
	require 'rubygems'
	require 'hpricot' # version 0.6
	# require_gem 'hpricot', '<= 0.6'
end
require 'net/http'
require 'cgi'
require 'fileutils' # for making directories

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'wowr/exceptions.rb'
require 'wowr/extensions.rb'
require 'wowr/classes.rb'

module Wowr
	class API
		VERSION = '0.2.3'
		
		@@armory_url_base = 'wowarmory.com/'
		
		@@search_url = 'search.xml'
		
		@@character_sheet_url = 'character-sheet.xml'
		@@character_talents_url = 'character-talents.xml'
		@@character_skills_url = 'character-skills.xml'
		@@character_reputation_url = 'character-reputation.xml'
		
		@@guild_info_url = 'guild-info.xml'
		
		@@item_info_url = 'item-info.xml'
		@@item_tooltip_url = 'item-tooltip.xml'
		
		@@arena_team_url = 'team-info.xml'
		
		@@max_connection_tries = 10
		
		@@cache_directory_path = 'cache/'
		
		cattr_accessor :armory_url_base, :search_url,
									 :character_sheet_url, :character_talents_url, :character_skills_url, :character_reputation_url,
									 :guild_info_url,
									 :item_info_url, :item_tooltip_url,
									 :arena_team_url,
									 :max_connection_tries,
									 :cache_directory_path
				
		@@search_types = {
			#:all => 'all',	# TODO: All is too complex at the moment, API doesn't return all results in one query
			:item => 'items',
			:character => 'characters',
			:guild => 'guilds',
			:arena_team => 'arenateams'
		}
		
		@@arena_team_sizes = [2, 3, 5]
		
		# TODO: Rename locale to server?
		attr_accessor :character_name, :guild_name, :realm, :locale, :lang, :caching, :debug
		
		def initialize(options = {})
			@character_name = options[:character_name]
			@guild_name			= options[:guild_name]
			@realm					= options[:realm]
			@locale					= options[:locale] || 'us'
			@caching				= options[:caching] == nil ? true : false
			@lang						= options[:lang].nil? ? 'default' : options[:lang]
			@debug					= options[:debug] || false
			
			# if (options[:lang].nil?)
			# 	@lang = 'default'
			# else
			# 	@lang					= options[:lang]
			# end
			
		end
		
				
		# General-purpose search
		# All specific searches are wrappers around this method.
		# Caching is disabled for searching
		def search(string, options = {})
			if (string.is_a?(Hash))
				options = string
			else
				options.merge!(:search => string)
			end
			
			options = merge_defaults(options)
			
			if options[:search].nil? || options[:search].empty?
				raise Wowr::Exceptions::NoSearchString.new
			end
			
			if !@@search_types.has_key?(options[:type])
				raise Wowr::Exceptions::InvalidSearchType.new(options[:type])
			end
			
			options.merge!(:caching => false)
			options.delete(:realm) # all searches are across realms
			
			xml = get_xml(@@search_url, options)
			
			results = []
			
			if (xml) && (xml%'armorySearch') && (xml%'armorySearch'%'searchResults')
				case options[:type]
					
					# TODO: Filter stuff
					when @@search_types[:item]
						(xml%'armorySearch'%'searchResults'%'items'/:item).each do |item|
							results << Wowr::Classes::SearchItem.new(item)
						end
					
					when @@search_types[:character]
						(xml%'armorySearch'%'searchResults'%'characters'/:character).each do |char|
							results << Wowr::Classes::Character.new(char)
						end
					
					when @@search_types[:guild]
						(xml%'armorySearch'%'searchResults'%'guilds'/:guild).each do |guild|
							results << Wowr::Classes::Guild.new(guild)
						end
					
					when @@search_types[:arena_team]
						(xml%'armorySearch'%'searchResults'%'arenaTeams'/:arenaTeam).each do |team|
							results << Wowr::Classes::ArenaTeam.new(team)
						end
				end
			end
			
			return results
		end
		
				
		# Characters
		# Note searches go across all realms by default
		# Caching is disabled for searching
		def search_characters(name, options = {})
			if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:search => name)
			end
			
			options.merge!(:type => :character)
			return search(options)
		end
		
		# Get the full details of a character
		def get_character(name = @character_name, options = {})
			if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:character_name => name)
				
				# TODO check
				options = {:character_name => @character_name}.merge(options) if (!@character_name.nil?)
			end
			options = merge_defaults(options)
			
			if options[:character_name].nil?
				raise Wowr::Exceptions::CharacterNameNotSet.new
			
			elsif (options[:realm].nil?)
				raise Wowr::Exceptions::RealmNotSet.new
			end
			
			character_sheet = get_xml(@@character_sheet_url, options)
			character_skills = get_xml(@@character_skills_url, options)
			character_reputation = get_xml(@@character_reputation_url, options)
			
			if true
				return Wowr::Classes::FullCharacter.new(character_sheet,
																								character_skills,
																								character_reputation)
			else
				raise Wowr::Excceptions::CharacterNotFound.new(options[:character_name])
			end
		end
		
		
		# DEPRECATED
		def get_character_sheet(name = @character_name, options = {})
			return get_character(name, options)
			# if (name.is_a?(Hash))
			# 	options = name
			# else
			# 	options.merge!(:character_name => name)
			# 	options = {:character_name => @character_name}.merge(options) if (!@character_name.nil?)
			# end
			# 
			# # options = {:character_name => @character_name}.merge(options) if (!@character_name.nil?)
			# 
			# options = merge_defaults(options)
			# 
			# if options[:character_name].nil?
			# 	raise Wowr::Exceptions::CharacterNameNotSet.new
			# 
			# elsif (options[:realm].nil?)
			# 	raise Wowr::Exceptions::RealmNotSet.new
			# 	
			# end
			# 
			# xml = get_xml(@@character_sheet_url, options)
			# 
			# # resist_types = ['arcane', 'fire', 'frost', 'holy', 'nature', 'shadow']
			# # @resistances = {}
			# # resist_types.each do |res|
			# # 	@resistances[res] = Wowr::Classes::Resistance.new(xml%'resistances'%res)
			# # end
			# # puts @resistances.to_yaml
			# return Wowr::Classes::CharacterSheet.new(xml)
		end
		
		
		
		def search_guilds(name, options = {})
			if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:search => name)
			end
			
			options.merge!(:type => :guild)
			return search(options)
		end
		
		# guild name is optional, assuming it's set in the api constructor
		def get_guild(name = @guild_name, options = {})
			if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:guild_name => name)
			end
			
			options = merge_defaults(options)
			
			xml = get_xml(@@guild_info_url, options)
			
			if (xml%'guildKey') && !(xml%'guildInfo').children.empty?
				return Wowr::Classes::Guild.new(xml)
			else
				raise Wowr::Exceptions::GuildNotFound.new(options[:guild_name])
			end
			

		end
		
		


		def search_items(name, options = {})
			if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:search => name)
			end
			
			options.merge!(:type => :item)
			return search(options)
		end
		
		# TODO: Is not finding the item an exception or just return nil?
		#def get_item(options = {:item_id => nil, :locale => @locale})
			
			#return Wowr::Classes::ItemTooltip.new(xml%'itemTooltip')
		#end
		
		def get_item(id, options = {})
			if (id.is_a?(Hash))
				options = id
			else
				options.merge!(:item_id => id)
			end
			
		end
		
		
		def get_item_info(id, options = {})
			if (id.is_a?(Hash))
				options = id
			else
				options.merge!(:item_id => id)
			end
			
			options = merge_defaults(options)
			xml = get_xml(@@item_info_url, options)
			
			if (xml%'itemInfo'%'item')
				return Wowr::Classes::ItemInfo.new(xml%'itemInfo'%'item')
			else
				# return nil
				raise Wowr::Exceptions::ItemNotFound.new("Item not found with id: #{options[:item_id]}")
			end
		end
		
		
		def get_item_tooltip(id, options = {})
			if (id.is_a?(Hash))
				options = id
			else
				options.merge!(:item_id => id)
			end
			
			options = merge_defaults(options)
			xml = get_xml(@@item_tooltip_url, options)
			
			if xml.nil?
				# return nil
				raise Wowr::Exceptions::ItemNotFound.new("Item not found with id: #{options[:item_id]}")
			end
			return Wowr::Classes::ItemTooltip.new(xml%'itemTooltip')
		end
		
		
		# 
		# Search for arena teams with the given name of any size across all realms on the specified locale
		# Caching is disabled for searching
		#  * name (String)
		def search_arena_teams(name, options = {})
			if (name.is_a?(Hash))
				options = name
			else
				options.merge!(:search => name)
			end
			
			options.merge!(:type => :arena_team)
			return search(options)
		end
		
		# Get the arena team of the given name and size, on the specified realm
		# Note realm is required
		#  * name (String)
		#  * size (Fixnum) Must be 2, 3 or 5
		def get_arena_team(name, size = nil, options = {})
			if name.is_a?(Hash)
				options = name
			elsif size.is_a?(Hash)
				options = size
				options.merge!(:team_name => name)
			else
				options.merge!(:team_name => name, :team_size => size)
			end
			
			options = merge_defaults(options)
						
			if options[:team_name].nil? || options[:team_name].empty?
				raise Wowr::Exceptions::ArenaTeamNameNotSet.new
			end
			
			if options[:realm].nil? || options[:realm].empty?
				raise Wowr::Exceptions::RealmNotSet.new
			end
			
			if !@@arena_team_sizes.include?(options[:team_size])
				raise Wowr::Exceptions::InvalidArenaTeamSize.new("Arena teams size must be: #{@@arena_team_sizes.inspect}")
			end
			
			xml = get_xml(@@arena_team_url, options)
			
			if !(xml%'arenaTeam').children.empty?
				return Wowr::Classes::ArenaTeam.new(xml%'arenaTeam')
			else
				raise Wowr::Exceptions::ArenaTeamNotFound.new(options[:team_name])
			end
		end
		
		
		# Clear the cache, optional filename
		def clear_cache(cache_path = @@cache_directory_path)
			begin
				FileUtils.remove_dir(cache_path)
			rescue Exception => e 
				
			end
		end
		
		
		
		
		protected
		
		def merge_defaults(options = {})
			defaults = {}
			# defaults[:character_name] = @charater_name if @charater_name
			# defaults[:guild_name]	= @guild_name if @guild_name
			defaults[:realm] 		= @realm 		if @realm
			defaults[:locale] 	= @locale 	if @locale
			defaults[:lang] 		= @lang 		if @lang
			defaults[:caching] 	= @caching 	if @caching
			defaults[:debug] 		= @debug 		if @debug
			
			# overwrite defaults with any given options
			defaults.merge!(options)
		end
		
		# TODO: pretty damn hacky
		def get_xml(url, options = {})
			# puts options.to_yaml
			
			# better way of doing this?
			# Map custom keys to the HTTP request values 
			reqs = {
				:character_name => 'n',
				:realm => 'r',
				:search => 'searchQuery',
				:type => 'searchType',
				:guild_name => 'n',
				:item_id => 'i',
				:team_size => 'ts',
				:team_name => 't'
			}
			
			params = []
			options.each do |key, value|
				if reqs[key]
					params << "#{reqs[key]}=#{u(value)}"
				end
			end
			
			if params.size > 0
				query = '?' + params.join('&')
			end
			
			# locale = options[:locale] || @locale
			
			base = self.base_url(options[:locale])
			full_query = base + url + query
			
			if options[:debug]
				puts full_query
			end
			
			if options[:caching]
				response = get_cache(full_query, options)
			else
				response = http_request(full_query, options)
			end
			
			if options[:debug]
				# puts response
			end
			
			doc = Hpricot.XML(response)
			# begin
				errors = doc.search("*[@errCode]")
				#errors.to_yaml
				if errors.size > 0
					errors.each do |error|
						raise Wowr::Exceptions::raise_me(error[:errCode], options)
					end
				elsif (doc%'page').nil?
					raise Wowr::Exceptions::EmptyPage
				else
					return (doc%'page')
				end
			# rescue Exception => e
			# 	$stderr.puts "Fatal error ((#{e.to_s})): Couldn't search the XML document."
			# 	$stderr.puts doc
			# 	exit 1
			# end
			
		end
		
		# TODO Rename
		def http_request(url, options = {})
			
			req = Net::HTTP::Get.new(url)#, headers)
			req["user-agent"] = "Mozilla/5.0 Gecko/20070219 Firefox/2.0.0.2"
			req["cookie"] = "cookieMenu=all; cookieLangId=" + options[:lang] + "; cookies=true;"
			
			uri = URI.parse(url)
			
		  http = Net::HTTP.new(uri.host, uri.port)
		
			begin
		
			  http.start do
			    res = http.request req
					response = res.body
			  end
			rescue 
				raise Wowr::Exceptions::ServerDoesNotExist.new('Specified server at ' + url + ' does not exist.');
			end
			
			# tries = 0
			# 			response = case res
			# 			when Net::HTTPSuccess, Net::HTTPRedirection
			# 				res.body
			# 			else
			# 				tries += 1
			# 				if tries > @@max_connection_tries
			# 					raise Wowr::Exceptions::NetworkTimeout.new('Timed out')
			# 				else
			# 					retry
			# 				end
			# 			end
			
			
			#response = res.body
			
			# while
			# 				tries += 1
			# 				if tries > @@max_connection_tries
			# 					raise Wowr::Exceptions::NetworkTimeout.new('Timed out')
			# 				else
			# 					retry
			# 				end
			# 			end
			# 			
			# 			begin
			# 				res = Net::HTTP.new(uri.host, uri.port).start {|http| http.request(req) }
			# 			rescue Timeout::Error => e
			# 				retry  
			# 				#raise Wowr::Exceptions::NetworkTimeout.new('Timed out')
			# 			end
			# 			
			# 			tries = 0
			# response = case res
			# when Net::HTTPSuccess, Net::HTTPRedirection
			# 	res.body
			# else
			# 	
			# end
		end
				
		def get_cache(url, options = {})
			
			path = @@cache_directory_path + options[:lang] + '/' + url_to_filename(url)
			
			# file doesn't exist, make it
			if !File.exists?(path)
				if options[:debug]
					puts 'Cache doesn\'t exist, making: ' + path
				end
				
				# make sure dir exists
				FileUtils.mkdir_p(localised_cache_path(options[:lang])) unless File.directory?(localised_cache_path(options[:lang]))
				
				xml_content = http_request(url, options)
				
				# write the cache
				file = File.open(path, File::WRONLY|File::TRUNC|File::CREAT)
				file.write(xml_content)
				file.close
			
			# file exists, return the contents
			else
				if options[:debug]
					puts 'Cache already exists, read: ' + path
				end
				
				file = File.open(path, 'r')
				xml_content = file.read
				file.close
			end
			return xml_content
		end
		
		# :nodoc:
		# remove http://eu.wowarmory.com/ leaving just xml file and request
		# Kind of assuming incoming URL is the same as the current locale
		def url_to_filename(url)
			path = url.gsub(base_url, '')
			return path
		end
		
		# :nodoc:
		def localised_cache_path(lang = @lang)
			@@cache_directory_path + lang
		end
				
		# :nodoc:
		def base_url(locale = @locale)
			if locale == :us
				'http://www.' + @@armory_url_base
			else
				'http://' + locale + '.' + @@armory_url_base
			end
		end
				
		# :nodoc:
		def u(str)
			if str.instance_of?(String)
				return CGI.escape(str)
			else
				return str
			end
		end
	end
end