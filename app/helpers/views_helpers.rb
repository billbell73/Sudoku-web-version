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