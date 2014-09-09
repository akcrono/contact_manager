require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'

get '/' do
  if params[:page]
    @page_number = params[:page].to_i
  else
    @page_number = 1
  end
  @contacts = Contact.limit(5).offset((@page_number - 1) * 5)
  erb :index
end

get '/contacts/new' do
  erb :'contacts/new'
end

get '/contacts/:id' do

  @contact = Contact.find(params[:id])
  erb :show
end

get '/search' do
  @search = "%" + params[:search_results] + "%"
  @contacts = Contact.where("first_name ILIKE ?
                            or last_name ILIKE ?
                            or CONCAT(first_name, ' ', last_name) ILIKE ?", @search, @search, @search)
  erb :search
end

post '/contacts' do
  @contact = Contact.new(params[:contact])
  if @contact.save
    redirect '/'
  else
    render :'contacts/new'
  end

end
