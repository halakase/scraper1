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
  business_address = business.css("p[class=adr]").each do |ba|
  business_phone = business.css("div.phones.phone.primary").each do |bp|
  business_web = business.css("div.links a").each do |bw|
    @businesses << {:name => bn.content, :address => ba.content, :phone => bp.content, :website => bw.content }
  end
  end
  end
  end
  # business_address = business.css("a[class=business-address]").content
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

=begin
# w mode on CSV open clears previous content
CSV.open("data.csv", "wb") do |csv|
  csv << HEADERS.map { |h| @businesses }
  csv << "\n"
  f.write(csv)
end
=end
