require 'rubygems'
require 'test/unit'
require 'yaml'
# require 'rr'
require 'shoulda'

$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'wowr'

XML_BASE = File.join(File.dirname(__FILE__) + '/xml/')
SAVE_PATH = File.join(File.dirname(__FILE__),'downloads')

module Wowr
  class API

    @@cache_directory_path = 'test_cache/'

    # def get_xml(url, opts = {})
    # 	response = File.open(url,'r')
    # 	begin
    # 		doc = Hpricot.XML(response)
    # 		# xml = check_exception(response)
    # 		# ret = []
    # 		# return xml if just_xml
    # 		# xml.search("//rowset/row").each do |elem|
    # 		# 	ret << klass.new(elem)
    # 		# end
    # 		# ret
    # 	ensure
    # 		response.close
    # 		
    # 	end
    # end

    # def process_query(klass,url,just_xml,args = {})
    # 	response = File.open(url,'r')
    # 	@last_hash = compute_hash(args.merge({:url => url, :just_hash => true })) # compute hash
    # 	begin
    # 		xml = check_exception(response)
    # 		ret = []
    # 		return xml if just_xml
    # 		xml.search("//rowset/row").each do |elem|
    # 			ret << klass.new(elem)
    # 		end
    # 		ret
    # 	ensure
    # 		response.close
    # 	end
    # end
  end
end
