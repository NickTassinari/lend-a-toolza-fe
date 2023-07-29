class ToolsController < ApplicationController
  def index 
    @tools = ToolFacade.get_tools
  end
end