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

get '/admin_connect' do
  haml :admin_connect
end

post '/admin_connect' do
  if params["login"] == "admin1" and params["password"]=="wdi"
    session[:admin] = true
    redirect "/admin"
  end
  haml :admin_connect
end

get '/admin' do
  if session[:admin] == false
    redirect "/"
  else session[:admin] == true
    redirect "/update/:id"
  end
end

get '/post/:id' do
  sql = "SELECT * FROM posts WHERE id=#{params[:id]} limit 1"
  @results = db.exec(sql).first
  haml :view_post
end

get '/create_post' do
  haml :create_post
end

post '/create_post' do
    if (params[:title].length > 0)
      sql = "insert into posts (title, content, creation_date, author) values ('#{params[:title]}', '#{params[:content]}', '#{params[:creation_date]}', '#{params[:author]}')"
      @results = db.exec(sql)
    redirect to '/'
  else
    haml :create_post
  end
end

get '/delete/:id' do
  sql = "delete from posts where id = #{params[:id]}"
  @results = db.exec(sql)
  haml :delete_post
end


get '/update/:id' do
    sql = "select * from posts where id = #{params[:id]} limit 1"
    @results = db.exec(sql).first
  haml :edit
end

post '/update/:id' do
  sql = "update posts set title='#{params[:title]}', content='#{params[:content]}', creation_date='#{params[:creation_date]}', author='#{params[:author]}' where id='#{params[:id]}'"
  @results = db.exec(sql)
  redirect "/post/#{params[:id]}"
  haml :edit
end

