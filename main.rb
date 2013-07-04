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

get '/lyrics/:id' do
  @lyrics = Song.get(params[:id])

  if @lyrics
    erb :lyrics
  else
    erb :not_found
  end
end

not_found do
  erb :not_found
end


