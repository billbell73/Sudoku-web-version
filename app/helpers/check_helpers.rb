def prepare_to_check_solution
  @check_solution = session[:check_solution]
  @wrong_guesses_second_time = session[:wrong_guesses_second_time]
  session[:wrong_guesses_second_time] = nil
  @wrong_guesses_third_time = session[:wrong_guesses_third_time]
  session[:wrong_guesses_third_time] = nil
  if @check_solution
    session[:wrong_guesses_second_time] = true
  end
  if @wrong_guesses_second_time
    session[:wrong_guesses_third_time] = true
  end
  session[:check_solution] = nil
end


def replace_wrong_guesses_with_zero solution, current_solution
  (0..80).each do |index|
    if solution[index].to_i != current_solution[index].to_i
        current_solution[index] = "0"
    end
  end
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