class Tool
  attr_reader :id, :name, :description, :image, :status, :user_id, :address, :latitude, :longitude, :borrower_id

  def initialize(response)
    @id = response[:id]
    @name = response[:attributes][:name]
    @description = response[:attributes][:description]
    @image = response[:attributes][:image]
    @status = response[:attributes][:status]
    @user_id = response[:attributes][:user_id]
    @address = response[:attributes][:address]
    @latitude = response[:attributes][:latitude]
    @longitude = response[:attributes][:longitude]
    @borrower_id = response[:attributes][:borrower_id]

  end
end