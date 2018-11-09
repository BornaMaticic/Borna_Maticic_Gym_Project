require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/session.rb' )
also_reload( '../models/*' )

get '/sessions' do
  @session = Session.all()
  erb ( :"sessions/index" )
end

get '/sessions/:id' do
  @session = Session.find(params['id'].to_i)
  erb(:"sessions/show")
end
