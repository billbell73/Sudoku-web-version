get '/' do
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution] #|| session[:puzzle]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  if @wrong_guesses_third_time
    replace_wrong_guesses_with_zero @solution, @current_solution
  end
  insert_in_main_form "/", "post", "Check values entered"
  erb :index
end

post '/' do
  cells = box_order_to_row_order(params["cell"])  
  session[:current_solution] = cells.map{|value| value.to_i }.join
  session[:check_solution] = true
  redirect to("/")
end