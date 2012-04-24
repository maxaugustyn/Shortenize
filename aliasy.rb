require 'sinatra'
require 'sinatra/reloader'
require 'thin'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-sqlite-adapter'

class MyApp < Sinatra::Base
    configure :development do 
        register Sinatra::Reloader
    end
end


def random_str(size = 3)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    effect = (0...size).map{ charset.to_a[rand(charset.size)] }.join
    if effect == Url.first(:u_id => effect) #check if there is the same unique key in database 
        random_str(size += 1 ) 
    else
        effect
    end 
end


DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/urls.db") 

class Url
    include DataMapper::Resource
    property :id, Serial
    property :u_id, String, :unique => true
    property :address, String, :required => true, :format => :url, :messages => {
        :format => "Not an URL",
        :presence => "Can't be empty unless you bribe me."
    } 
    property :suggestion, String,  :required => true, :unique => true, :messages => {
        :presence => "Can't be empty unless you bribe me.",
        :unique => "Someone else has been already using it."
    }
end

DataMapper.finalize
DataMapper.auto_upgrade!



get '/' do 
    erb :index
end

post '/' do
	@link = Url.new(params) 
    @link.save
    @message = ""
    if @link.save 
        @message = "This is your link:" + request.url + @link.suggestion  
    else
        @link.errors.each do |e|
            @message << e.join
        end
    end
    erb @message, :layout => !request.xhr? 
end


get '/:suggestion' do 
	redirection = Url.first(:suggestion => params[:suggestion])
    if redirection
	   redirect redirection[:address]
    else
        redirect '/'
    end       
end
