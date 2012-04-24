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

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/urls.db") #there was my mistake! colon instead of dot.

class Url
    include DataMapper::Resource
    property :id, Serial
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
	query = params[:suggestion]
	redirection = Url.first(:suggestion => query)
    if redirection
	   redirect redirection[:address]
    else
        redirect '/'
    end       
end
