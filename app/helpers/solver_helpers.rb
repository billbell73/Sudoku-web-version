def solve_user_inputted puzzle
  sudoku = Sudoku.new(puzzle)
  sudoku.solve!
  sudoku.to_s.chars
end


def blank_sudoku
  81.times.inject([]){ |memo| memo << "0" }
end
