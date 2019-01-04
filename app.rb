require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('rubygems')
require( 'rake' )
require_relative('controllers/sessions_controller')
require_relative('controllers/members_controller')
require_relative('controllers/bookings_controller')
require_relative('controllers/instructors_controller')


get '/' do
  erb( :index )
end
