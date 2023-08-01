class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @user_tools = ToolFacade.users_tools(@user.id)
    @borrowed_tools = ToolFacade.users_b_tools(@user.id)
  end
end