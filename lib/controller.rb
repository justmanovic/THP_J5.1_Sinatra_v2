require 'gossip'
require 'csv'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals:{ragots: Gossip.read_all}
  end

  get '/gossips/new/' do # Quand on clique sur 'Ajouter un gossip'
    erb :new_gossip
  end

  post '/gossips/new/' do # Quand on envoie le formulaire
    Gossip.new(params[:gossip_author],params[:gossip_content]).save
    erb :new_gossip_confirmation
  end

  get '/gossips/confirm/' do # La page de confirmation après avoir posté un gossip
    erb :new_gossip_confirmation
  end

  get '/gossip/:num_gossip/' do # Quand on clique sur 'voir le gossip'
    erb :show_one, locals:{ragots: Gossip.read_all, gossip_numb:params[:num_gossip]}
  end

  get '/gossip/:num_edit/edit/' do 
    erb :edit, locals:{ragots: Gossip.read_all, gossip_numb:params[:num_edit]}
  end

  post '/gossip/:num/edit/' do
    Gossip.edit(params[:gossip_author_updated],params[:gossip_content_updated],params[:num])
    redirect '/gossip/edit/confirm/'
  end

  get '/gossip/edit/confirm/' do
    erb :edit_confirm
  end

end