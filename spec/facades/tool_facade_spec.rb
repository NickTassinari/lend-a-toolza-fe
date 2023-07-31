require 'rails_helper'
require "./app/facades/tool_facade"

RSpec.describe ToolFacade do
  
  it "exists and returns attributes" do 
    tools_response = File.read('spec/fixtures/tools_index.json')
        stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/tools")
          .to_return(status: 200, body: tools_response)
    # expect(tool_facade).to be_a(ToolFacade)
    tools = ToolFacade.get_tools
    expect(tools).to_not be_empty 
    expect(tools[0].name).to eq("Item Excepturi Rem")
    expect(tools[0].borrower_id).to eq("33")
    expect(tools[0].description).to eq("Perferendis reprehenderit fugiat sit eos. Corporis ipsum ut. Natus molestiae quia rerum fugit quis. A cumque doloremque magni.")
    expect(tools[0].image).to eq("image.jpg")
    expect(tools[0].latitude).to eq("53.076645")
    expect(tools[0].longitude).to eq("10.3398")
    expect(tools[0].address).to eq("123 Sunnyside Dr, Lebanon, IN, 46052")
    expect(tools[0].status).to eq("unavailable")
    expect(tools[0].user_id).to eq("12")
  end
end