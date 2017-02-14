require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'rest-client'
require 'csv'


page = Nokogiri::HTML(RestClient.get("http://www.yellowpages.com/search?search_terms=logistics&geo_location_terms=55114")) do |config|
  config.strict.noblanks
end

@businesses = Array.new
page.css('.result').each do |business|
  business_name = business.css("a[class=business-name]").each do |bn|
    # puts bn.content
  business_street = business.search("span[class=street-address]")
    business_street.each do |bst|
  business_locality = business.search("span[class=locality]")
    business_locality.each do |bly|

  # business_region = business.search("span[class=addressRegion]")
    # business_region.each do |brn|
  # business_zipcode = business.search("span[class=postalCode]")
    # business_zipcode.each do |bzp|
  # business_postal = business.search("span[class=postalCode]")
    # business_postal.each do |bpt|
  business_phone = business.css("div.phones.phone.primary").each do |bp|
  business_web = business.css("div.links a").map { |link| link['href'] }
  business_web = business.css("div.links a").map{|link| "#{link['href']}"}
  business_web.each do |bw|
    @businesses << {:Name => bn.content, :Street => bst.text, :Locality => bly.text, :Region => bly.next_element.text, :ZipCode => bly.next_element.next_element.text, :Phone => bp.content, :Website => bw }
  end
  end
  end
  end
  end
end

# display hash result
puts @businesses


# Get headers, the keys for each hash key-value pair
headers = @businesses[0].keys
puts headers

CSV.open("data.csv", "wb", headers: :first_row) do |csv|
  # write the headers to the CSV
  csv << headers
  # iterate over the hashes
  @businesses.each do |bz|
  # extract values and write to CSV file
  csv << bz.values_at(*headers)
end
end
