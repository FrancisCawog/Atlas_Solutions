file_path = "soccer.dat"

minimum_team = []
minimum_goal_diff = Float::INFINITY

puts "What column do you want returned: "
data_returned = gets.chomp
puts "What first column do you want to compare: "
column1_data = gets.chomp
puts "What second column do you want to compare: "
column2_data = gets.chomp

team_index = nil
for_index = nil
against_index = nil
header = true
header_length = nil

File.foreach(file_path) do |rows|
  row = rows.split

  if header && row.include?(data_returned)
    team_index = row.index(data_returned)
    for_index = row.index(column1_data)
    against_index = row.index(column2_data)
    header = false
    header_length = row.length
    next
  end

  next if header

  row.reject! { |element| element =~ /^[^\w\s]+$/ }

  next unless row[for_index] =~ /^\d+$/

  row_diff = (header_length - row.length).abs

  goal_diff = (row[for_index + row_diff].to_i - row[against_index + row_diff].to_i).abs

  if goal_diff < minimum_goal_diff
    minimum_goal_diff = goal_diff
    minimum_team = [row[team_index + row_diff]]
  elsif goal_diff == minimum_goal_diff
    minimum_team.push(row[team_index + row_diff])
  end
end

puts "The #{data_returned} with the lowest spread difference between #{column1_data} and #{column2_data} is #{minimum_team.join(', ')}"
