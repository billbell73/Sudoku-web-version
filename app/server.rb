require 'sinatra'
require 'sinatra/partial' 
require 'rack-flash'
require 'newrelic_rpm'

require_relative 'models/sudoku'
require_relative 'models/cell'

require_relative 'controllers/root'
require_relative 'controllers/solver'
require_relative 'controllers/solution'

require_relative 'helpers/views_helpers'
require_relative 'helpers/check_helpers'
require_relative 'helpers/new_puzzle_helpers'
require_relative 'helpers/solver_helpers'
require_relative 'helpers/form_helpers'


enable :sessions
set :session_secret, "I'm the secret key to sign the cookie"
use Rack::Flash
set :partial_template_engine, :erb