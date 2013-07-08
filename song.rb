require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Song
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :lyrics, Text
	property :length, Integer
	property :released_on, Date

  # def released_on=date
  #   super Date.strptime(date, '%m/%d/%Y')
  # end

  #validation stuff

  greater_than_zero = Proc.new do |length| 
    case length 
    when Fixnum
      length > 0
    else
      false
    end
  end
  
  validates_presence_of :title
  validates_presence_of :released_on
  validates_presence_of :lyrics
  validates_presence_of :length
  validates_format_of   :length, with: greater_than_zero, message: "Length must be greater than zero."

end

DataMapper.finalize
llDataMapper.auto_upgrade!