get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    redirect '/'
    # decided where to redirect?
  else
    @errors =
    erb :'users/login'
  end
end

get '/users/new' do

  erb :'users/register'

end
