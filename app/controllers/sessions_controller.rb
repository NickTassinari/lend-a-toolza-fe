# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(google_id: auth_hash['uid'])

    user ||= User.create!(
      name: auth_hash['info']['name'],
      email: auth_hash['info']['email'],
      google_id: auth_hash['uid']
    )
    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
