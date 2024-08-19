file_path = "w_data.dat"

minimum_day = []
minimum_spread = Float::INFINITY

day_index = nil
max_index = nil
min_index = nil
header = true

File.foreach(file_path) do |rows|
    row = rows.split

    if header && row.include?("Dy")
        day_index = row.index("Dy")
        max_index = row.index("MxT")
        min_index = row.index("MnT")
        header = false
        next
    end

    if !header
        next unless row[day_index] =~ /^\d+$/

        spread = row[max_index].to_i - row[min_index].to_i

        if spread < minimum_spread
            minimum_spread = spread
            minimum_day = [row[day_index].to_i]
        elsif spread == minimum_spread
            minimum_day.push(row[day_index].to_i)
        end
    end
end

print minimum_day