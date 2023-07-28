class SessionsControler < ApplicationController
  def create 
    def create
      auth_hash = request.env['omniauth.auth']
      user = User.find_by(uid: auth_hash['uid'])
  
      if user
        session[:user_id] = user.id
      else
        user = User.create!(
          name: auth_hash['info']['name'],
          email: auth_hash['info']['email'],
          google_id: auth_hash['uid']
          token = auth_hash['credentials']['token']
        )
        session[:user_id] = user.id
      end
  
      redirect_to root_path
    end

  def destroy 
    session[:user_id] = nil 
    redirect_to root_path 
  end


  private 

  def auto_hash
    request.env['omniauth.auth']
  end
end