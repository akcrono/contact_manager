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
