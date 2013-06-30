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
  sql = "select * from posts"
  @results = db.exec(sql)
haml :index
end

get '/post/:id' do
  sql = "select * from posts where id = #{params[:id]} limit 1"
  @result = deb.exec(sql).first
  haml :view_post
end

# post '/post/:id/edit' do
#   puts 'homepage'
# end

# get '/admin_connect' do
#   if params["login"]== "admin1" and params["password"]=="wdi"
#     session[:admin] = true
#     redirect "/admin" #page not created yet...
# end

# get '/admin' do
#   unless session[:admin] == true
#     redirect "/"
# end