class StoresController < ApplicationController
  def index 
    radius = params[:radius]
    location = params[:location]
    @stores = StoreFacade.get_stores(location, radius)
  end
end