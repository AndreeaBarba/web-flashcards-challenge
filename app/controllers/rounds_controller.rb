before '/rounds/:round_id/cards/:card_id' do
  redirect '/error' unless session[:user_id]
end

get '/rounds/:round_id/cards/:card_id' do
  @round = Round.find(params[:round_id])
  @card = Card.find(params[:card_id])
  erb :'cards/show'
end

post '/rounds/:round_id/cards/:card_id' do

  guess = Guess.create(:user_answer => params[:user_answer], :card_id => params[:card_id], :round_id => params[:round_id])
  @round_id = params[:round_id]
  session[:counter] += 1
  session[:cards].rotate!
  if guess.user_answer == guess.card.answer
    guess.correct? == true
    @message = "You are correct!"
    session[:cards].pop
  else
    guess.correct? == false
    @message = "You are incorrect! The answer is: #{guess.card.answer}"
  end
  ep session
  erb :"/cards/feedback"
end


get '/' do

end
