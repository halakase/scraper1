require 'csv'

csv = CSV.generate do |csv|
    csv << ['header 1', 'header 2', 'header 3']
    csv << ['summin 1', 'summin 2', 'summin 3']
    csv << ['summin 4', 'summin 5', 'summin 6']
end

# Values for new column (including header)
new_values = ['header 4', 'new value 1', 'new value 2']

i = 0
CSV.parse(csv) do |row|

    new_csv = CSV.generate do |new_csv|
        new_csv << row + [new_values[i]]
        i += 1
    end
    puts new_csv
    
end
