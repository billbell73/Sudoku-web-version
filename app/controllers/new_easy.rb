get '/new_easy' do 
	session.clear
	generate_puzzle :easy
	redirect to ("/")
end
