#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: 'sqlite3', database: 'untiblog'}

class Client

end

get '/' do
	erb :index
end

post '/' do
  @client = Client.new params[:client]
end