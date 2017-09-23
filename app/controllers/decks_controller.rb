get '/decks' do
  @decks = Deck.all
  erb :'decks/index'
end

get '/error' do
  erb :'404'
end

before '/decks/:id' do
  redirect '/error' unless session[:user_id]
end

get '/decks/:id' do
  found_deck = Deck.find(params[:id])
  card_count = found_deck.cards.count
  ep cards = (1..card_count).to_a
  ep shuffled_cards = cards.shuffle
  @round = Round.create(deck_id: params[:id], user_id:
    session[:user_id])
  ep @round
  session[:round] = { @round.id => shuffled_cards }
  session[:curr_index] = 0
  ep session
  session[:current_card] = session[:round][@round.id][session[:curr_index]]
  redirect "/rounds/#{@round.id}/cards/#{session[:current_card]}"
end
