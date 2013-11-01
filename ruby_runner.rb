# 3.times do |row|
        
#   3.times do |box|

#     3.times do |cell_row|
            
#       3.times do |cell|

#         cell_index = row * 27 + box * 3 + cell_row * 9 + cell
#         puts "ERB_Cell_Index: #{cell_index}"
#         puts "cell: #{cell}"
#         puts "cell_row: #{cell_row}"
#         puts "box: #{box}"
#         puts "row: #{row}"
#         puts
#       end
      
#     end
  
#   end

# end


def rows(cells)
    (0..COLUMN_SIZE-1).inject([]) do |rows, index|
      rows << cells.slice(index * COLUMN_SIZE, COLUMN_SIZE)
    end
  end

def columns(cells, rows)
    (0..COLUMN_SIZE-1).inject([]) do |cols, index|
      cols << rows.map{|row| row[index]}
    end
  end

def boxes(rows)    
    (0..BOX_SIZE-1).inject([]) do |boxes, i|
      relevant_rows = rows.slice(BOX_SIZE * i, BOX_SIZE)
      boxes + relevant_rows.transpose.each_slice(BOX_SIZE).map(&:flatten)       
    end        
  end


  COLUMN_SIZE = 9
  cells = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80] 
  BOX_SIZE = Math.sqrt(COLUMN_SIZE)

puts "cells"
p cells

puts "rows(cells):"
p rows(cells)

puts "columns(cells, rows(cells):"  
p columns(cells, rows(cells))

puts "boxes(rows(cells))"
p boxes(rows(cells))