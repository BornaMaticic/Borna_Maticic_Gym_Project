require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/member.rb' )
also_reload( '../models/*' )

get '/members' do
  @members = Member.all()
  erb ( :"members/index" )
end

get '/members/new' do
  @sessions = Session.all
  erb(:"members/new")
end

get '/members/:id' do
  @member = Member.find(params['id'].to_i)
  erb( :"members/show" )
end


post '/members' do
  Member.new(params).save
  redirect to '/members'
end



get '/members/:id/edit' do
  @member = Member.find(params[:id])
  erb(:"members/edit")
end

get '/members/:id/edit' do
  @member = Member.find(params[:membership_type])
  erb(:"members/edit")
end

post '/members/:id' do
  member = Member.new(params)
  member.update
  redirect to "/members/#{params['id']}"
end

post '/members/:id/delete' do
  member = Member.find(params['id'])
  member.delete
  redirect to '/members'
end
