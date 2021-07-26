require 'gossip'
require 'csv'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals:{ragots: Gossip.read_all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params[:gossip_author],params[:gossip_content]).save
    erb :new_gossip_confirmation
  end

  get '/gossips/confirm/' do
    erb :new_gossip_confirmation
  end

  get '/gossip/:num_gossip/' do
    erb :show_one, locals:{ragots: Gossip.read_all, gossip_numb:params[:num_gossip]}
  end

  get '/gossipmodif/:num_edit/edit/' do
    erb :edit, locals:{ragots: Gossip.read_all, gossip_numb:params[:num_edit]}
  end

  post '/gossipmodif/:num/edit/' do
    Gossip.edit(params[:gossip_author_updated],params[:gossip_content_updated],params[:num])
    redirect '/gossipmodif/edit/confirm/'
  end

  get '/gossipmodif/edit/confirm/' do
    erb :edit_confirm
  end

end