class Store 
  attr_reader :id, :name, :location

  def initialize(data)
    require 'pry'; binding.pry
    @id = data[:id]
  end
end