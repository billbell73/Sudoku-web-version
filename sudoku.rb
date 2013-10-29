

require 'sinatra'
require_relative './lib/sudoku'
require_relative './lib/cell'

# class Sudoku_board

    def random_sudoku
        # we're using 9 numbers, 1 to 9, and 72 zeros as an input
        # it's obvious there may be no clashes as all numbers are unique
        seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
        sudoku = Sudoku.new(seed.join)
        # then we solve this (really hard!) sudoku
        sudoku.solve!
        # and give the output to the view as an array of chars
        sudoku.to_s.chars
        # seed
    end

    # def puzzle_maker sudoku
    #   puzzle = []
    #   sudoku.each do |val|
    #     puzzle << [val, val, nil].sample
    #   end
    #   puzzle
    # end

    def puzzle_maker sudoku
      puzzle = []
      sudoku.each do |val|
        random_number = Random.rand(0..100)
        if random_number < 30
          puzzle << val
        else
          puzzle << nil
        end
      end
      puzzle
    end

# end

# new_board = Sudoku_board.new

    get '/' do
        sudoku = random_sudoku
        # @current_solution = new_board.random_sudoku
        #@current_solution = puzzle_maker sudoku
        @current_solution = random_sudoku
      erb :index
    end
