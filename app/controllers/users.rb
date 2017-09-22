get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/'
    # decided where to redirect?
  else
    @errors = "Username or password was invalid!"
    erb :'users/login'
  end
end

get '/users/new' do
  erb :'users/register'
end

post '/users/new' do
  user = User.new(params[:user])
  if user.save
    user.encrypted_password = user[:password]
    user.save!
    redirect '/users/login'
    # redirect to log in page
  else
    @errors  = user.errors.full_messages
    erb :'/users/register'
  end
end

get '/users/logout' do
  session.delete(:user_id)
  redirect '/users/login'
end
