require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'


page = Nokogiri::HTML(RestClient.get("http://www.yellowpages.com/search?search_terms=logistics&geo_location_terms=55114")) do |config|
  config.strict.noblanks
end

# urls = ["http://stackoverflow.com", "http://example.com", "http://foobar.com"]
# p writes obj.inspect to the standard output
# p res = urls.map{|url| {"url"=>url, "dns_status"=>200, "title"=>url[7..-5]} }

# Get names from CSS, put into Array of names
@names = Array.new
page.css("a[class=business-name]").each do |nm|
  @names << {:name => nm.content}
  end

puts @names
