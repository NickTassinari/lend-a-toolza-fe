class Store 
  attr_reader :id, :name, :formatted_address

  def initialize(data)
    @id = data[:id]
    @name = data[:attributes][:name]
    @formatted_address = data[:attributes][:formatted_address]
  end
end