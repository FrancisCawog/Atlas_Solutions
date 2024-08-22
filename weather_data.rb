file_path = "w_data.dat"

minimum_result = []
minimum_spread = Float::INFINITY

puts "What column do you want returned: "
data_returned = gets.chomp
puts "What first column do you want to compare: "
column1_data = gets.chomp
puts "What second column do you want to compare: "
column2_data = gets.chomp

returned_index = nil
column1_index = nil
column2_index = nil
header = true

File.foreach(file_path) do |rows|
    row = rows.split

    if header && row.include?("#{data_returned}")
        returned_index = row.index("#{data_returned}")
        column1_index = row.index("#{column1_data}")
        column2_index = row.index("#{column2_data}")
        header = false
        next
    end

    if !header

        next unless row[returned_index] =~ /^\d+$/

        spread = (row[column1_index].to_i - row[column2_index].to_i).abs

        if spread < minimum_spread
            minimum_spread = spread
            minimum_result = [row[returned_index].to_i]
        elsif spread == minimum_spread
            minimum_result.push(row[returned_index].to_i)
        end
    end
end

if !minimum_result.empty?
    print "The #{data_returned} with the lowest spread difference between #{column1_data} and #{column2_data} is #{minimum_result.join(', ')}"
else
    print "Invalid data, make sure inputted data is properly capitalized"
end