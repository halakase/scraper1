require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'


page = Nokogiri::HTML(RestClient.get("http://www.yellowpages.com/search?search_terms=logistics&geo_location_terms=55114")) do |config|
  config.strict.noblanks
end

puts page.class   # => Nokogiri::HTML::Document

# Create Struct To Hold Everything
Company.new("Page", :businessname, :address, :phones, :websites)

page.css('title').each do |el|
  puts el.text  # => Page Title
end

# get names
names = page.css("a[class=business-name]")
names.each do |el|
  puts el.text
end

# get addresses
address = page.css("p[class=adr]")
address.each do |el|
  puts el.text
end

# get phones
phones = page.css("div.phones.phone.primary")
phones.each do |el|
  puts el.text
end

# get websites
websites = page.css("div.links a")
websites.each{|link| puts "#{link['href']}"}
websites.each do |el|
  puts el.text
end

# write into structures



# This is awesome for doing ruby regex. http://rubular.com/
