
get '/rounds/:round_id/cards/:card_id' do
  @deck = Deck.find(params[:round_id])
  @card = Card.find(params[:card_id])
  erb :'cards/show'
end

post '/rounds/:round_id/cards/:card_id' do
  @guess = Guess.create(:user_answer => params[:user_answer, :card_id => params[:card_id]
end
