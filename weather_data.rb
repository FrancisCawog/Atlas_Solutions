file_path = "w_data.dat"

minimum_day = []
minimum_spread = Float::INFINITY

day_index = nil
max_index = nil
min_index = nil
header = true

File.foreach(file_path) do |row|
    columns = row.split

    if header && columns.include?("Dy")
        day_index = columns.index("Dy")
        max_index = columns.index("MxT")
        min_index = columns.index("MnT")
        header = false
        next
    end

    if !header
        next unless columns[day_index] =~ /^\d+$/

        spread = columns[max_index].to_i - columns[min_index].to_i

        if spread < minimum_spread
            minimum_spread = spread
            minimum_day = [columns[day_index].to_i]
        elsif spread == minimum_spread
            minimum_day.push(columns[day_index].to_i)
        end
    end
end

print minimum_day