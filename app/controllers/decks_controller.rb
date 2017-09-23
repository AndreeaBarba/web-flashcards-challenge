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
  cards = (1..card_count).to_a
  shuffled_cards = cards.shuffle
  round = Round.create(deck_id: params[:id], user_id:
    session[:user_id], guess_count: 0)
  session[:round] = round.id
  session[:cards] = shuffled_cards
  session[:deck_size] = shuffled_cards.length
  session[:counter] = 0
  redirect "/rounds/#{session[:round]}/cards/#{session[:cards][0]}"
end

