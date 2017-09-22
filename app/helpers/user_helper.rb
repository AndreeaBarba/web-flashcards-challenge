module UserHelper

  def logged_in?
    session[:user_id]
  end

  def correct_user_logged_in?(user)
    session[:user_id] == user.id
  end

  def user_session
    user = User.find(session[:user_id])
  end

end

helpers UserHelper
