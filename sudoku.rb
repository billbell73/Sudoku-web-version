require 'sinatra'
require 'sinatra/partial' 
require 'rack-flash'
require 'newrelic_rpm'

require_relative './lib/sudoku'
require_relative './lib/cell'


enable :sessions
set :session_secret, "I'm the secret key to sign the cookie"
use Rack::Flash
set :partial_template_engine, :erb

def random_sudoku
    seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
    sudoku = Sudoku.new(seed.join)
    sudoku.solve!
    sudoku.to_s.chars
end

def solve_user_inputted puzzle
  sudoku = Sudoku.new(puzzle)
  sudoku.solve!
  sudoku.to_s.chars
end

def puzzle sudoku
  puzzle = []
  sudoku.each do |val|
    random_number = Random.rand(0..100)
    if random_number < 60
      puzzle << val
    else
      puzzle << "0"
    end
  end
  puzzle
end

def blank_sudoku
  81.times.inject([]){ |memo| memo << "0" }
end

get '/' do
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution] #|| session[:puzzle]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  @button_text = "Check values entered"
  erb :index
end

get '/solver' do
  @current_solution = blank_sudoku
  @solution = blank_sudoku
  @puzzle = blank_sudoku
  @button_text = "Load inputted puzzle"
  erb :solver
end

get '/solution' do
  @current_solution = session[:solution]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  erb :solution
end

post '/' do
  cells = box_order_to_row_order(params["cell"])  
  session[:current_solution] = cells.map{|value| value.to_i }.join
  session[:check_solution] = true
  redirect to("/")
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



def box_order_to_row_order(cells)
  boxes = cells.each_slice(9).to_a
  (0..8).to_a.inject([]) {|memo, i|
      first_box_index = i / 3 * 3
      three_boxes = boxes[first_box_index, 3]
      three_rows_of_three = three_boxes.map do |box| 
      row_number_in_a_box = i % 3
      first_cell_in_the_row_index = row_number_in_a_box * 3
      box[first_cell_in_the_row_index, 3]
    end
    memo += three_rows_of_three.flatten
  }
end 

def generate_new_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = puzzle(sudoku)
  session[:current_solution] = session[:puzzle]    
end

def prepare_to_check_solution
  @check_solution = session[:check_solution]
  if @check_solution
    flash[:incorrect_msg] = "Guessed wrong"
    flash[:value_provided] = "Original puzzle"
    flash[:inputted_correctly] = "Correct.  Woohoo!"
  # else
  # # if class is animated rotateout replace with 0
  end
  session[:check_solution] = nil
end

helpers do

  def colour_class(check_button_just_clicked, puzzle_value, current_solution_value, solution_value)
    zero_on_original_puzzle = puzzle_value == "0"
    now_not_zero = current_solution_value.to_i != 0
    different_from_solution = current_solution_value != solution_value

    if check_button_just_clicked && 
        zero_on_original_puzzle && 
        now_not_zero && 
        different_from_solution
      'incorrect-just-entered'
    elsif !check_button_just_clicked && 
        zero_on_original_puzzle && 
        now_not_zero && 
        different_from_solution
        'animated rotateOut'
    elsif zero_on_original_puzzle && 
        now_not_zero && 
        !different_from_solution
      'correct-guess'
    elsif !zero_on_original_puzzle
      'value-provided'
    end
  end

   def cell_value(value)
    value.to_i == 0 ? '' : value
  end

end
