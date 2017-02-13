require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'


page = Nokogiri::HTML(RestClient.get("http://www.yellowpages.com/search?search_terms=logistics&geo_location_terms=55114")) do |config|
  config.strict.noblanks
end

# get names
names = page.css("a[class=business-name]").each do |nm|
  b_names = {:name => nm.content}
  puts b_names
  end

# get names and phone numbers
phones = page.css("div.phones.phone.primary").each do |ph|
  b_phones = {:phone => ph.content}
  puts b_phones
  end
