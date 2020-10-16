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
  @comments = Comment.where(post_id: @post_id).take
  @c_i = @comments.message

  erb :comment
end


# It's Example!!!! Make that's 
# User.find_each do |user|
#   NewsMailer.weekly(user).deliver_now
# end

# <% @comments.each do |comment| %>
#     <p>
#       <%= comment.message %>
#     </p>
#   <% end %>
