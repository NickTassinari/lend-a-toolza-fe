require 'rails_helper'
require './app/poros/tool'
require './app/services/tools_service'

RSpec.describe Tool do 
  it "exists and has attributes" do 
  
  tool_data =  {
          "id": "2425",
          "type": "tool",
          "attributes": {
            "name": "Crazy Thors Hammer",
            "description": "Crazy Shit",
            "image": "image.jpg",
            "status": "available",
            "user_id": "12",
            "location": "123 Sunnyside Dr, Lebanon, IN, 46052",
            "latitude": "53.076645",
            "longitude": "10.3398",
            "borrow_id": "33"
          }
        }

    tool = Tool.new(tool_data)
    
    expect(tool.id).to eq("2425")
    expect(tool.name).to eq("Crazy Thors Hammer")
    expect(tool.description).to eq("Crazy Shit")
    expect(tool.image).to eq("image.jpg")
    expect(tool.status).to eq("available")
    expect(tool.user_id).to eq("12")
    expect(tool.location).to eq("123 Sunnyside Dr, Lebanon, IN, 46052")
    expect(tool.latitude).to eq("53.076645")
    expect(tool.longitude).to eq("10.3398")
    expect(tool.borrow_id).to eq("33")
  end
end