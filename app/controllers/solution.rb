get '/solution' do
  @current_solution = session[:solution]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
  @button_text = "Back to incomplete puzzle"
  @action = "/"
  erb :solution
end
