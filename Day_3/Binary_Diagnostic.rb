# DAY 3

def binaryDiagnostic(arr) 

    gamma = ""
    epsilon = ""

    n = arr.length
    m = arr[0].length - 1

        
    for col in 0...m

        zero = 0
        one = 0

        for row in 0...n
            if arr[row][col] == '0'
                zero += 1
            else
                one += 1
            end
        end

        if one > zero 
            gamma << "1"
            epsilon << "0"
        else
            gamma << "0"
            epsilon << "1"
        end

    end

    gammaDec = gamma.to_i(2)
    epsilonDec = epsilon.to_i(2)

    puts gammaDec*epsilonDec

end

arr = File.readlines('input.txt')
#puts binaryDiagnostic(arr)



def binaryDiagnostic2(arr)

    n = arr.length
    m = arr[0].length - 1
    o2arr = []
    co2arr = []
    
    zero = 0
    one = 0

    for row in 0...n
        if arr[row][0] == '0'
            zero += 1
        else
            one += 1
        end
    end

    if zero > one 
        mostCommon = "0"
    else 
        mostCommon = "1"
    end

    for row in 0...n
        if arr[row][0] == mostCommon
            o2arr.push(arr[row])
        else 
            co2arr.push(arr[row])
        end
    end

    col = 1

    while o2arr.length > 1 || co2arr.length > 1 do

        if o2arr.length > 1
            zero = 0
            one = 0
    
            for row in 0...o2arr.length
                if o2arr[row][col] == '0'
                    zero += 1
                else
                    one += 1
                end
            end

            if zero > one 
                mostCommon = "0"
            else 
                mostCommon = "1"
            end
            
            row = 0
            while o2arr.length > 1 && row < o2arr.length do
                if o2arr[row][col] != mostCommon
                    o2arr.delete_at(row)
                else
                    row += 1
                end
            end 

        end

        if co2arr.length > 1
            zero = 0
            one = 0
    
            for row in 0...co2arr.length
                if co2arr[row][col] == '0'
                    zero += 1
                else
                    one += 1
                end
            end

            if zero <= one 
                leastCommon = "0"
            else 
                leastCommon = "1"
            end

            row = 0
            while co2arr.length > 1 && row < co2arr.length do
                if co2arr[row][col] != leastCommon
                    co2arr.delete_at(row)
                else
                    row += 1
                end
            end 

        end

        col += 1
    end


    o2 = o2arr[0]
    co2 = co2arr[0]


    o2Dec = o2.to_i(2)
    co2Dec = co2.to_i(2)

    puts o2Dec*co2Dec
end

#puts binaryDiagnostic2(arr)
