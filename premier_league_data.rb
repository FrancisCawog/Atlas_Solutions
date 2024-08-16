file_path = "soccer.dat"

minimum_team = nil
minimum_goal_diff = Float::INFINITY

File.foreach(file_path) do |row|
    columns = row.split

    next unless columns[9] =~ /^\d+$/

    goal_diff = (columns[6].to_i - columns[8].to_i).abs

    if goal_diff < minimum_goal_diff
        minimum_goal_diff = goal_diff
        minimum_team = columns[1]
    end
end

print minimum_team