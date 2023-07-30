class Tool
  attr_reader :name,
              :description,
              :image,
              :status,
              :location
  def initialize(attributes)
    @name = attributes[:data][0][attributes][:name]
    @description = attributes[:data][0][attributes][:description]
    @image = attributes[:data][0][attributes][:image]
    @status = attributes[:data][0][attributes][:status]
    @location = attributes[:data][0][attributes][:location]
  end
end