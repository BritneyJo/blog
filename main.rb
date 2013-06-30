require 'pry'
require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'haml'

db = PG.connect(dbname: 'todo_database', host: 'localhost')

get '/' do
haml :index
end

get '/posts' do
end

get '/post/:id' do
end

post '/post/:id/edit' do
  puts 'homepage'
end