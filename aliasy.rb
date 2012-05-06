require 'sinatra'
require 'unicorn'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-sqlite-adapter'


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
    property :address, String,
        :required => true,
        :format   => :url,
        :messages => {
            :format => "not an URL",
            :presence => "can't be empty unless you bribe me"
            
        }
        
    property :suggestion, String, 
             :required => true,
             :unique   => true,
             :messages => {
                 :presence => "can't be empty unless you bribe me",
                 :unique => "someone else has been already using it"
             }
             
    # u_id != suggestion
end

DataMapper.finalize
DataMapper.auto_upgrade!



get '/' do 
    erb :index
end

post '/' do
	@link = Url.new(params) 
    @link[:u_id] = random_str 
    @link.save
    if @link.save
        erb :success, :layout => !request.xhr? 
    else
        erb :failure, :layout => !request.xhr? #How to DRY it down?
    end
end


get '/:shortcut' do 
    if shortcut = Url.first(:suggestion => params[:shortcut])
        shortcut
    elsif shortcut = Url.first(:u_id => params[:shortcut])
        shortcut
    else
        shortcut = nil
    end

    redirect shortcug[:address] unless shortcut.nil?
end
