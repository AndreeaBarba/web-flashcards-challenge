before '/rounds/:round_id/cards/:card_id' do
  ep session
  ep params
  redirect '/error' unless session[:user_id] && session[:round] == params[:round_id].to_i && session[:cards][0] == params[:card_id].to_i
end

get '/rounds/:round_id/cards/:card_id' do
  @round = Round.find(params[:round_id])
  @card = Card.find(params[:card_id])
  erb :'cards/show'
end

post '/rounds/:round_id/cards/:card_id' do

  guess = Guess.find_or_create_by(:card_id => params[:card_id], :round_id => params[:round_id])
  guess.user_answer = params[:user_answer]
  @round_id = params[:round_id]
  session[:counter] += 1
  session[:cards].rotate!
  session[:guesses] += 1
  if guess.user_answer == guess.card.answer

    if guess.correct == nil
      guess.is_first_try = true
    else
      guess.is_first_try = false
    end

    guess.correct = true
    @message = "You are correct!"
    session[:cards].pop
  else
    guess.correct = false
    @message = "You are incorrect! The answer is: #{guess.card.answer}"
  end
  guess.save

  if session[:counter] == session[:deck_size]
    if session[:cards].empty?
      @finished = true
      # Round.find(@round_id).guess_count = session[:guesses]
    else
      session[:counter] = 0
      session[:deck_size] = session[:cards].length
      session[:cards].shuffle!
    end
  end
  erb :"/cards/feedback"
end

get '/rounds/:round_id/finish' do
  @round = Round.find(params[:round_id])
  @round.update(guess_count: session[:guesses])
  @round.save!
  session.delete(:cards)
  session.delete(:round)
  session.delete(:counter)
  session.delete(:deck_size)
  session.delete(:guesses)
  session.delete(:notice)
  erb :'/cards/finish'
end

delete '/rounds/:round_id' do
  session.delete(:round)
  session.delete(:cards)
  session.delete(:deck_size)
  session.delete(:counter)
  session.delete(:guesses)
  session.delete(:notice)
  Guess.where("round_id = #{params[:round_id]}").destroy_all
  Round.destroy(params[:round_id])
  redirect '/decks'
end






