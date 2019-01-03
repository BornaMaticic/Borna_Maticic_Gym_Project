require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/sessions_controller')
require_relative('controllers/members_controller')
require_relative('controllers/bookings_controller')
require_relative('controllers/instructors_controller')
require 'bundler/capistrano'

get '/' do
  erb( :index )
end
