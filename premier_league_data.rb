file_path = "soccer.dat"

minimum_team = []
minimum_goal_diff = Float::INFINITY

team_index = nil
for_index = nil
against_index = nil
header = true

File.foreach(file_path) do |row|
    columns = row.split

    if header && columns.include?("Team")
        team_index = columns.index("Team")
        for_index = columns.index("F")
        against_index = columns.index("A")
        header = false
        next
    end

    if !header
        next unless columns[for_index] =~ /^\d+$/
        puts "#{columns}"

        goal_diff = (columns[for_index].to_i - columns[against_index].to_i).abs

        if goal_diff < minimum_goal_diff
            minimum_goal_diff = goal_diff
            minimum_team = [columns[team_index]]
        elsif goal_diff == minimum_goal_diff
            minimum_team.push(columns[team_index])
        end
    end
end

print minimum_team