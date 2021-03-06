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
  validates_presence_of :released_on, message: "Release Date must not be blank"
  validates_primitive_type_of :released_on, message: "Release Date must be dd/mm/yyyy"
  validates_presence_of :lyrics
  validates_presence_of :length
  validates_format_of   :length, with: greater_than_zero, message: "Length must be greater than zero"

end

DataMapper.finalize
