before '/rounds/:round_id/cards/:card_id' do
  redirect '/error' unless session[:user_id]
end

get '/rounds/:round_id/cards/:card_id' do
  @round = Round.find(params[:round_id])
  # @deck = Round.find(params[:round_id]).deck
  @card = Card.find(params[:card_id])
  erb :'cards/show'
end

post '/rounds/:round_id/cards/:card_id' do
  @guess = Guess.create(:user_answer => params[:user_answer], :card_id => params[:card_id])
end
