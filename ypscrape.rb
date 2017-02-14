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


=begin
# get names
names = page.css("a[class=business-name]")
names.each do |el|
  puts el.text
end
=end


=begin
# get street addresses
address = page.css("p[class=adr]")
address.each do |el|
  puts el.text
end
=end

bizstreet = Array.new
page.css('.result').each do |business|
business_street = business.search("span[class=street-address]")
  business_street.each do |bst|
  puts bst.text
end
end
# puts bizstreet

# get city / region
# 'Locality', company.search("span[class=locality]").text,


# get state
# 'addressRegion', company.search("span[class=addressRegion]").text,

# get postal code
# 'postalCode', company.search("span[class=postalCode]").text,


=begin
# get phones
phones = page.css("div.phones.phone.primary")
phones.each do |el|
  puts el.text
end
=end

=begin
# get websites
@webnames = Array.new
websites = page.css("div.links a").map{|link| "#{link['href']}"}
websites.each do |bw|
  @webnames << {:webn => bw }
end
# puts websites
puts @webnames
=end

=begin
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

=begin
company_info = page.css("div.info").map{ |company|
    [
      'businessname', company.at("a[class=business-name]").content
      # 'BusinessAddress', page.at("p[class=adr]").text,
      # 'Phone', company.at("div.phones.phone.primary").content
    ]
  }
=end

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
