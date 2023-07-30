require 'rails_helper'

RSpec.describe "Tool Show Page" do 
  it "shows tool info" do 
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

    allow(ToolsService).to receive(:get_tools_by_id).with("2425").and_return(tool_data)
    tool = Tool.new(tool_data)

    visit "/tools/#{tool.id}"

    expect(page).to have_content("Crazy Thors Hammer")
  end
end