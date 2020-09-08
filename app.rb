#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: 'sqlite3', database: 'untiblog'}

class Client < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :password, presence: true
end

class Post < ActiveRecord::Base

end

get '/' do
  @c = Client.new

	erb :index
end

post '/' do
  @c = Client.new params[:client]
  if @c.save == true
    erb 'Спасибо за регистрацию, чтобы перейти на главную страницу нажмите на эту ссылку: <a href="/posts">redirect to main page</a>'
  else
    @error = @c.errors.full_messages.first
    erb :index
  end
end

get '/posts' do
  erb :posts
end

post '/posts' do
  erb :posts
end