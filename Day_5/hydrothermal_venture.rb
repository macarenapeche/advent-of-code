arr = File.readlines('input.txt')
arr.map! { |item| 
    item = item.split(" -> ")
    item.map! { |sub| 
        sub = sub.gsub("\n", "").split(",")
    }
}

arr.map! { |item| 
    item.map! { |row| 
        row.map! { |col|
            col = col.to_i
        }
    }
}


def hydro_venture(arr)
    lines = Hash.new    
    arr.select! {|pt| pt[0][0] == pt[1][0] || pt[0][1] == pt[1][1] }

    arr.each do |pt|
        if pt[0][0] == pt[1][0]
            y1 = [pt[0][1], pt[1][1]].min
            y2 = [pt[0][1], pt[1][1]].max

            (y1..y2).each do |y|
                if lines.has_key?([pt[0][0], y])
                    lines[[pt[0][0], y]] += 1
                else
                    lines[[pt[0][0], y]] = 1
                end
            end

        elsif pt[0][1] == pt[1][1]
            x1 = [pt[0][0], pt[1][0]].min
            x2 = [pt[0][0], pt[1][0]].max

            (x1..x2).each do |x|
                if lines.has_key?([x, pt[0][1]])
                    lines[[x, pt[0][1]]] += 1
                else
                    lines[[x, pt[0][1]]] = 1
                end
            end
        end
    end

    lines.select! { |k, v| v >= 2 }
    puts lines
    return lines.length

end

def increase_hash(lines, x, y)
    if lines.has_key?([x, y])
        lines[[x, y]] += 1
    else 
        lines[[x, y]] = 1
    end
    return lines
end

def create_line(arr)
    x1 = arr[0][0]
    y1 = arr[0][1]
    x2 = arr[1][0]
    y2 = arr[1][1]


    result = []
    if x1 < x2
        y = y1 
        (x1..x2).each do |x| 
            result << [x, y]
            y += 1 if y1 < y2
            y -= 1 if y1 > y2
        end
    elsif x1 == x2 
        x = x1 
        if y1 < y2 
            (y1..y2).each do |y|
                result << [x, y]
            end
        elsif y1 == y2
            result << [x, y1]
        else 
            y1.downto(y2) do |y|
                result << [x,y]
            end
        end
    else
        y = y1 
        x1.downto(x2) do |x| 
            result << [x, y]
            y += 1 if y1 < y2
            y -= 1 if y1 > y2
        end
    end


    return result
end

def hydro_venture2(arr)
    lines = Hash.new    

    arr.each do |pt|
        line_array = create_line(pt)
        line_array.each { |item| increase_hash(lines, item[0], item[1])}
    end

    lines.select! { |k, v| v >= 2 }
    return lines.length

end

puts hydro_venture2(arr)
