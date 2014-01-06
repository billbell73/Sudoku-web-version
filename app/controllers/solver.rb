get '/solver' do
  @current_solution = blank_sudoku
  @solution = blank_sudoku
  @puzzle = blank_sudoku
  @button_text = "Load inputted puzzle"
  @action = "/solver"
  erb :solver
end

post '/solver' do
  cells = box_order_to_row_order(params["cell"])  
  p cells
  puzzle = cells.map{|value| value.to_i }.join
  sudoku = solve_user_inputted puzzle
  session[:current_solution] = puzzle
  session[:puzzle] = puzzle
  session[:solution] = sudoku
  redirect to("/")
end