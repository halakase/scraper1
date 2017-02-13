require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'

page = Nokogiri::HTML(RestClient.get("http://www.yellowpages.com/search?search_terms=logistics&geo_location_terms=55114")) do |config|
  config.strict.noblanks
end


g = { 'hellologistics' => '1237893737', 'friendlylogistics' => '9996781256', 'openlogistics' => '9028374920' }
# Get names from CSS, put into Array of names
@names = Array.new
page.css("a[class=business-name]").each do |nm|
  @names << nm.content
  end

@h_names = {:name => @names}
puts @h_names
