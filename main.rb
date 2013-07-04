require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'rubygems'
require './song'


get '/' do
  erb :home
end

get '/about' do
  @title = "All About This Website"
  erb :about
end

get '/contact' do
  @title = "Contact"
  erb :contact
end

get '/songs' do
  @songs = Song.all
  @title = "Songs"
  erb :songs
end

get '/songs/new' do
  @song = Song.new
  erb :new
end

get '/songs/:id' do
  @song = Song.get(params[:id])

  if @song
    erb :show_song
  else
    status 404
    erb :not_found
  end
end

post '/songs' do
  song = Song.create(params[:song])
  redirect to("/songs/#{song.id}")
end


not_found do
  erb :not_found
end


