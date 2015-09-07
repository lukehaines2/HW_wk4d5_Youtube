require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'

# db setup - run first
before do
  @db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do
  @db.close
end

# HOME
get '/' do
  redirect to '/videos'
end

# INDEX
get '/videos' do
  sql = 'select * from videos'
  
  # global variable = @db.exec(tags)
  @videos = @db.exec(sql)
  # link the page to index.erb
  erb :index
end

# NEW
get '/videos/new' do
  erb :new
end

# CREATE Vid
post '/videos' do
  sql = "insert into videos (title, url, description, genre) values ('#{params[:title]}', '#{params[:url]}', '#{params[:description]}' ) returning *"
  # .first to pull it out
  video = @db.exec(sql).first
  # redirect via vid 'id'
  redirect to "/videos/#{video['id']}"
end

# SHOW vid
get '/videos/:id' do
  # Select from all, and get editied videos by id. 
  sql = "select * from videos where id = #{params[:id]}"
  @video = @db.exec(sql).first

  erb :show
end

# EDIT vid
get '/videos/:id/edit' do
  sql = "select * from videos where id = #{params[:id]}"
  @video = @db.exec(sql).first

  erb :edit
end

# UPDATE vid
post '/videos/:id' do
  # Title, url, desc, genre, predefined id
  sql = "update videos and set title = '#{params[:title]}', url = '#{params[:url]}', description = '#{params[:description]}', genre = '#{params[:genre]}' where id = #{params[:id]}"
  @db.exec(sql)

  redirect to "/videos/#{params['id']}"
end

# DELETE
post '/videos/:id/delete' do
  sql = "Delete from videos where id = #{params[:id]}"
  @db.exec(sql)

  redirect to '/videos'
end


# RANDOM vid
# not restful routes or what??!
