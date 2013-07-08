require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'rubygems'
require './song'

helpers do
  def format_date(date)
    if date && date.respond_to?(:strftime)
      date.strftime("%m/%d/%Y") 
    else
      date
    end
  end
end

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

get '/songs/:id/edit' do
  @song = Song.get(params[:id])

  if @song
    erb :edit_song
  else
    status 404
    erb :not_found
  end
end

put '/songs/:id' do
  song = Song.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

post '/songs' do
  song = Song.create(params[:song])
  if song.save
    redirect to("/songs/#{song.id}")
  else
    @song = song
    erb :new
  end
end

delete '/songs/:id' do
  Song.get(params[:id]).destroy #motherfucker
  redirect to("/songs")
end

not_found do
  erb :not_found
end


