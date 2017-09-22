get '/decks' do
  @decks = Deck.all
  erb :'decks/index'
end

get '/decks/:id' do
  found_deck = Deck.find(params[:id])
  p found_deck
  card_count = Card.all.count
  random_card = rand(1..card_count)
  @round = Round.create(deck_id: params[:id], user_id: session[:user_id])
  redirect "/rounds/#{@round.id}/cards/#{random_card}"
end

