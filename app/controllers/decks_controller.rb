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
  ordered_cards = (1..card_count).to_a
  shuffled_cards = ordered_cards.shuffle
  @round = Round.create(deck_id: params[:id], user_id: session[:user_id])
  session[:round] = { :@round.id => shuffled_cards }
  session[:curr_index] = 0
  redirect "/rounds/#{@round.id}/cards/#{random_card}"
end

