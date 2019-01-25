require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/instructor.rb' )


get '/instructors' do
  @instructors = Instructor.all()
  erb ( :"instructors/index" )
end

get '/instructors/new' do
  @instructors = Instructor.all
  @sessions = Session.all
  erb(:"instructors/new")
end

get '/instructors/:id' do
  @instructor = Instructor.find(params['id'].to_i)
  erb( :"instructors/show" )
end


post '/instructors' do
  Instructor.new(params).save
  redirect to '/instructors'
end



get '/instructors/:id/edit' do
  @instructor = Instructor.find(params[:id])
  erb(:"instructors/edit")
end

post '/instructors/:id' do
  instructor = Instructor.new(params)
  instructor.update
  redirect to "/instructors"
end

post '/instructors/:id/delete' do
  instructor = Instructor.find(params['id'])
  instructor.delete
  redirect to '/instructors'
end
