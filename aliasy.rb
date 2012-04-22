require 'sinatra'
require 'thin'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-sqlite-adapter'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/form.db")

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

before do
    if request.xhr?
        @ajax = true
    else         
        @ajax = false
    end
end


get '/' do 
    erb :index #, :layout => :layout 
end

post '/' do
	@link = Url.new(:address => params[:address], :suggestion=> params[:suggestion]) 
    @link.save
    if @link.save
        DataMapper.auto_upgrade!
        erb :success , :layout => (request.xhr? ? true : false)
    else 
        erb :failure
    end   
    
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
