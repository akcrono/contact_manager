require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'

get '/' do
  if params[:page] != nil
    @page_number = params[:page].to_i
  else
      @page_number = 1
  end
  @contacts = Contact.all.limit(5).offset((@page_number-1)*5)
  # binding.pry
  erb :index
end

get '/contacts/:id' do

  @contact = Contact.find(params[:id])
  erb :show
end

get '/search' do
  @search = params[:search_results]
  @contacts = Contact.where("first_name ILIKE ? or last_name ILIKE ?", @search, @search)
  # whoudl be a way to search for full name.  Also, @search is redundant
  erb :search
end

get '/add' do

erb :add
end

post '/add' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @phone_number = params[:phone_number]
  Contact.create(first_name: @first_name, last_name: @last_name, phone_number: @phone_number)

  redirect '/'
end
