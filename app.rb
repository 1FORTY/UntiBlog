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
  validates :post_messsage, presence: true, length: { minimum: 10 }
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

get '/' do
  @c = Client.new

	erb :index
end

post '/' do
  @c = Client.new params[:client]
  if @c.save == true
    erb 'Спасибо за регистрацию, чтобы перейти на главную страницу нажмите на эту ссылку: <a href="/post">redirect to main page</a>'
  else
    @error = @c.errors.full_messages.first
    erb :index
  end
end

get '/post' do
  @posts = Post.order 'created_at DESC'

  erb :posts
end

post '/post' do
  @posts = Post.new params[:post]
  @posts.save

  redirect 'post'
end

get '/comment/:id' do
  @post_id = params[:id]
  @post = Post.find(@post_id)
  @c = Comment.all

  @date = []
  @c.each do |d|
    @date.push d.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  @comments = []
  @c.find_each do |user|
    @comments.push user.message if user.post_id == @post.id
  end

  erb :comment
end

post '/comment/:id' do
  @post_id = params[:id]
  @post = Post.find(@post_id)
  @c = Comment.all

  @comments = []
  @c.find_each do |user|
    @comments.push user.message if user.post_id == @post.id
  end

  @date = []
  @c.each do |d|
    @date.push d.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  c = Comment.new params[:comment]
  c.save

  erb :comment
end
