get '/solution' do
  @current_solution = session[:solution]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  insert_in_main_form "/", "get", "Back to incomplete puzzle"
  erb :solution
end
