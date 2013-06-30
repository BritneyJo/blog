require 'pry'
require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'haml'

db = PG.connect(dbname: 'blogposts', host: 'localhost')

configure do
  enable :session
end

get '/' do
  sql = "SELECT * FROM posts"
  @results = db.exec(sql)
haml :index
end

get '/post/:id' do
  sql = "SELECT * FROM posts WHERE id=#{params[:id]} limit 1"
  @results = db.exec(sql).first
  haml :view_post
end

post '/post/:id/edit' do
  puts 'post has been updated'
end

get '/admin_connect' do
  if params["login"] == "admin1" and params["password"]=="wdi"
    session[:admin] = true
    redirect "/"
    haml :admin_connect
  end
end

get '/admin' do
  unless session[:admin] == true
    redirect "/"
  end
end