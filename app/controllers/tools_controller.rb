class ToolsController < ApplicationController
  def index 
    keyword = params[:name]
    location = params[:location]
    @search_results = ToolFacade.search_tools_by_keyword(keyword, location)
  end

  def show 
    @tool = ToolFacade.get_tools_by_id(params[:id])
  end
end