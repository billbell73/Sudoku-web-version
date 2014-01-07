def generate_new_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = puzzle(sudoku)
  session[:current_solution] = session[:puzzle]    
end


def random_sudoku
    seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
    sudoku = Sudoku.new(seed.join)
    sudoku.solve!
    sudoku.to_s.chars
end


def puzzle sudoku, level=:medium
  puzzle = []
  difficulty = {hard: 50, medium: 60, easy: 70}
  sudoku.each do |val|
    random_number = Random.rand(0..100)
    if random_number > difficulty[level]
      puzzle << "0"
    else
      puzzle << val
    end
  end
  puzzle
end


def generate_puzzle level
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = puzzle(sudoku, level)
  session[:current_solution] = session[:puzzle] 
end  

