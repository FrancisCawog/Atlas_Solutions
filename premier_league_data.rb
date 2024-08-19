file_path = "soccer.dat"

minimum_team = []
minimum_goal_diff = Float::INFINITY

team_index = nil
for_index = nil
against_index = nil
header = true

header_length = nil

File.foreach(file_path) do |rows|
    row = rows.split

    if header && row.include?("Team")
        team_index = row.index("Team")
        for_index = row.index("F")
        against_index = row.index("A")
        header = false
        header_length = row.length
        next
    end

    if !header
        row.delete("-")
        next unless row[for_index] =~ /^\d+$/
        row_diff = (header_length - row.length).abs 
        puts "#{row}"

        goal_diff = (row[for_index + row_diff].to_i - row[against_index + row_diff].to_i).abs

        if goal_diff < minimum_goal_diff
            minimum_goal_diff = goal_diff
            minimum_team = [row[team_index + row_diff]]
        elsif goal_diff == minimum_goal_diff
            minimum_team.push(row[team_index + row_diff])
        end
    end
end

print minimum_team