require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ToolsService do 
  before :each do 
    tools_response = File.read('spec/fixtures/tools_index.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/tools")
      .to_return(status: 200, body: tools_response)

    tools_search = File.read('spec/fixtures/hammer_search.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/tools/search/hammer/IN")
      .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

      
  end
  it 'returns a list of tools' do 
    

      tools = ToolsService.get_tools
      expect(tools).to be_a Hash
      expect(tools[:data][0][:type]).to eq("tool")
      expect(tools[:data][0][:id]).to eq("2425")
      expect(tools[:data][0][:attributes]).to be_a(Hash)
      expect(tools[:data][0][:attributes][:name]).to be_a(String)
      expect(tools[:data][0][:attributes][:name]).to eq("Item Excepturi Rem")
      expect(tools[:data][0][:attributes][:description]).to eq("Perferendis reprehenderit fugiat sit eos. Corporis ipsum ut. Natus molestiae quia rerum fugit quis. A cumque doloremque magni.")
      expect(tools[:data][0][:attributes][:image]).to eq("image.jpg")
      expect(tools[:data][0][:attributes][:status]).to eq("unavailable")
      expect(tools[:data][0][:attributes][:user_id]).to eq("12")
      expect(tools[:data][0][:attributes][:location]).to eq("123 Sunnyside Dr, Lebanon, IN, 46052")
      expect(tools[:data][0][:attributes][:latitude]).to eq("53.076645")
      expect(tools[:data][0][:attributes][:longitude]).to eq("10.3398")
      expect(tools[:data][0][:attributes][:borrow_id]).to eq("33")

      expect(tools[:data][1][:type]).to eq("tool")
      expect(tools[:data][1][:id]).to eq("2427")
      expect(tools[:data][1][:attributes]).to be_a(Hash)
      expect(tools[:data][1][:attributes][:name]).to be_a(String)
      expect(tools[:data][1][:attributes][:name]).to eq("Item Illum Minus")
      expect(tools[:data][1][:attributes][:description]).to eq("Aut voluptatem aut officiis minima cum at. Est ea sed est quia repudiandae. Eum omnis rerum in adipisci aut. Deleniti sunt voluptatibus rerum aut quo omnis.")
      expect(tools[:data][1][:attributes][:image]).to eq("image.jpg")
      expect(tools[:data][1][:attributes][:status]).to eq("available")
      expect(tools[:data][1][:attributes][:user_id]).to eq("16")
      expect(tools[:data][1][:attributes][:location]).to eq("123 Sunnyside Dr, Lebanon, IN, 46052")
      expect(tools[:data][1][:attributes][:latitude]).to eq("53.076645")
      expect(tools[:data][1][:attributes][:longitude]).to eq("10.3398")
      expect(tools[:data][1][:attributes][:borrow_id]).to eq("nil")
  end

  xit 'returns tools based on keyword' do 

    keyword = "hammer"
    location = "IN"
    search = ToolsService.search_tools_by_keyword(keyword, location)
    expect(search).to be_a(Hash)
    expect(search[:results]).to be_an(Array)

    tool_data = search[:results].first
    expect(tool_data[:attributes][:name]).to eq("Kobalt Hammer")
  end 


end