class ToolsController < ApplicationController
  def index 
    keyword = params[:name]
    location = params[:location]
    @search_results = ToolFacade.search_tools_by_keyword(keyword, location)
  end

  def show 
    # require 'pry'; binding.pry
    @tool = Tool.find(params[:id])
  end
end