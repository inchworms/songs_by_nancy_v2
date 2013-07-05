require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'sinatra/flash'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Song
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :lyrics, Text
	property :length, Integer
	property :released_on, Date

  def released_on=date
    super Date.strptime(date, '%m/%d/%Y')
  end
  #validates
  # validates_length_of :title, length: 3...150
  validates_presence_of :title
  validates_presence_of :released_on
end

DataMapper.finalize