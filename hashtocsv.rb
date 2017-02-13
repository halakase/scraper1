require 'csv'

# Working CSV Writer
h = { 'hellologistics' => 'canine', 'friendlylogistics' => 'feline', 'openlogistics' => 'asinine' }
g = { 'hellologistics' => '1237893737', 'friendlylogistics' => '9996781256', 'openlogistics' => '9028374920' }
CSV.open("data.csv", "wb") {|csv| h.to_a.each {|elem| csv << elem} }
CSV.open("data.csv", "wb") {|csv| g.to_a.each {|elem| csv << elem} }


# Add another col, row by row:
table.each do |row|
  row["header_4"] = rand(9)
end

# write to file
CSV.open("test2.csv", "w") do |f|
  f << table.headers
  table.each{|row| f << row}
end



=begin
# Repetitive Writing to CSV File
h = { 'name' => 'canine' }
CSV.open( "data.csv", 'wb' ) do |writer|
  h.each do |s|
    writer << [s.name]
  end
end
=end
