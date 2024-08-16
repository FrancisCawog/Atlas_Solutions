file_path = "w_data.dat"

minimum_day = nil
minimum_spread = Float::INFINITY

File.foreach(file_path) do |row|
    columns = row.split

    next unless columns[0] =~ /^\d+$/

    spread = columns[1].to_i - columns[2].to_i

    if spread < minimum_spread
        minimum_spread = spread
        minimum_day = columns[0].to_i
    end
end

print minimum_day