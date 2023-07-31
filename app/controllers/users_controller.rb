class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @user_tools = ToolService.new.user_tools(@user.id)
    @borrowed_tools = ToolService.new.user_b_tools(@user.id)
  end
end