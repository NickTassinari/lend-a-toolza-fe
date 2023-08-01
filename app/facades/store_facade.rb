class StoreFacade
  def initialize(location, radius)
    @location = format_location(location)
    @radius = format_radius(radius.to_i)
  end

  def stores
    @stores ||= store_data.map do |data|
      Store.new(data)
    end
  end


  private 

  def service 
    @service ||= StoresService.new
  end

  def stores_data 
    @store_data ||= service.get_stores(@location, @radius)[:data]
  end

  def format_radius(miles)
    miles * 1600
  end

  def format_location(location)
    location.gsub(' ', '%20')
  end
end