class StoreFacade

  def self.get_stores(location, radius)
    location = location.gsub(' ', '%20')
    radius = (radius.to_i * 1600)
    StoresService.get_stores(location, radius)[:data].map do |store|
      Store.new(store)
    end
  end
end