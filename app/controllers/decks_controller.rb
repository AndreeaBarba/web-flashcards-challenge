get '/decks' do
  @decks = Deck.all
  erb :'decks/index'
end

get '/error' do
  erb :'404'
end

before '/decks/:id' do
  redirect '/error' unless session[:user_id]
  unless !session[:round]
    session[:notice] = true
    redirect '/decks'
  end
end

get '/decks/:id' do
  found_deck = Deck.find(params[:id])
  cards = found_deck.cards.pluck(:id)
  shuffled_cards = cards.shuffle
  round = Round.create(deck_id: params[:id], user_id:
    session[:user_id])
  session[:round] = round.id
  session[:cards] = shuffled_cards
  session[:deck_size] = shuffled_cards.length
  session[:counter] = 0
  session[:guesses] = 0
  redirect "/rounds/#{session[:round]}/cards/#{session[:cards][0]}"
end

