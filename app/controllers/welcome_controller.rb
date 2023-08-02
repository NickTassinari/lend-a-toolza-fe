class WelcomeController < ApplicationController
  def index; end

  def create 
      @project = params[:project]
      redirect_to result_path(project: @project)
    end
    
    def result 
      @project = params[:project]
      @chat_results = ChatFacade.chat_request(@project)
  end
end