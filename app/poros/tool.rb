class Tool
  attr_reader :id, :name, :description, :image, :status, :user_id, :location, :latitude, :longitude, :borrow_id

  def initialize(response)
    @id = response[:id]
    @name = response[:attributes][:name]
    @description = response[:attributes][:description]
    @image = response[:attributes][:image]
    @status = response[:attributes][:status]
    @user_id = response[:attributes][:user_id]
    @location = response[:attributes][:location]
    @latitude = response[:attributes][:latitude]
    @longitude = response[:attributes][:longitude]
    @borrow_id = response[:attributes][:borrow_id]

  end

  def self.find(id)
    tool_data = ToolsService.get_tools_by_id(id)
    Tool.new(tool_data) if tool_data
  end


end