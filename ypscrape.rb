require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'


page = Nokogiri::HTML(RestClient.get("http://www.yellowpages.com/search?search_terms=logistics&geo_location_terms=55114")) do |config|
  config.strict.noblanks
end

puts page.class   # => Nokogiri::HTML::Document


page.css('title').each do |el|
  puts el.text  # => Page Title
end



# get names
names = page.css("a[class=business-name]")
names.each do |el|
  puts el.text
end

=begin
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
# Create Struct To Hold Everything
# Company.new("Page", :businessname, :address, :phones, :websites)

# get all info

allinfo = page.css("div.v-card")
allinfo.each do |el|
  puts el.text
end
=end


=begin
company_info = page.css("div.info").map{ |company|
    [
      'businessname', company.at("a[class=business-name]").content
      # 'BusinessAddress', page.at("p[class=adr]").text,
      # 'Phone', company.at("div.phones.phone.primary").content
    ]
  }
=end

company_info = page.css("div.info").map{ |company|
    [
      'businessname', company.at("a[class=business-name]").content
      # 'BusinessAddress', page.at("p[class=adr]").text,
      # 'Phone', company.at("div.phones.phone.primary").content
    ]
  }

=begin
  company_info = page.css("p[class=adr]").map{ |company|
      [
        'StreetAddress', company.search("span[class=street-address]").text,
        'Locality', company.search("span[class=locality]").text,
        'addressRegion', company.search("span[class=addressRegion]").text,
        'postalCode', company.search("span[class=postalCode]").text,
        # 'Phone', company.at("div.phones.phone.primary").content
      ]
    }
=end

# puts company_info


# {business_name: ‘blah’, phone: ‘bbla’}

# Merge two structs

=begin
def struct_join(main, other)
  mems = main.members + other.members
  vals = main.values + other.values
  Struct.new(nil, *mems).new(*vals)
end
=end

# This is awesome for doing ruby regex. http://rubular.com/
