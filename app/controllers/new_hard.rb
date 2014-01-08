get '/new_hard' do 
	session.clear
	generate_puzzle :hard
	redirect to ("/")
end