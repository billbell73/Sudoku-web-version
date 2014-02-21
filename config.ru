
require './app/server'

use Rack::Static, :urls => ['/stylesheets', '/javascript'], :root => 'public'

run Sinatra::Application