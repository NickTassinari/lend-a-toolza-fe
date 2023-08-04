# frozen_string_literal: true

require 'rails_helper'
require './app/facades/tool_facade'

RSpec.describe ToolFacade, :vcr do
  
  it "exists and returns attributes" do 
    tools_response = File.read('spec/fixtures/tools_index.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/tools')
      .to_return(status: 200, body: tools_response)

    tools = ToolFacade.get_tools
    expect(tools).to_not be_empty
    expect(tools[0].name).to eq('Item Excepturi Rem')
    expect(tools[0].borrower_id).to eq('33')
    expect(tools[0].description).to eq('Perferendis reprehenderit fugiat sit eos. Corporis ipsum ut. Natus molestiae quia rerum fugit quis. A cumque doloremque magni.')
    expect(tools[0].image).to eq('image.jpg')
    expect(tools[0].latitude).to eq('53.076645')
    expect(tools[0].longitude).to eq('10.3398')
    expect(tools[0].address).to eq('123 Sunnyside Dr, Lebanon, IN, 46052')
    expect(tools[0].status).to eq('unavailable')
    expect(tools[0].user_id).to eq('12')
  end

  it 'returns tools based on keyword' do
    tools_search = File.read('spec/fixtures/hammer_search.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/tools/search?name=hammer&location=IN')
      .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

    keyword = 'hammer'
    location = 'IN'
    search = ToolFacade.search_tools_by_keyword(keyword, location)
    expect(search).to be_a(Array)
    expect(search.first).to be_a(Tool)
    expect(search.first.name).to eq('Kobalt Hammer')
    expect(search.first.address).to eq('123 Sunnyside Dr, Lebanon, IN, 46052')
    expect(search.first.borrower_id).to eq('nil')
    expect(search.first.description).to eq('This bad boy will cover all your framing needs. Crooked stud? Nail popping up? Wanna just whack something? This hammer is the perfect tool!')
    expect(search.first.id).to eq('1265')
    expect(search.first.image).to eq('image.jpg')
    expect(search.first.latitude).to eq('53.076645')
    expect(search.first.longitude).to eq('10.3398')
    expect(search.first.status).to eq('available')
    expect(search.first.user_id).to eq('15')
  end

  it 'returns tools by id' do
    saw_show = File.read('spec/fixtures/slam_saw_show.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/tools/1266")
      .to_return(status: 200, body: saw_show, headers: { 'Content-Type': 'application/json' })
      
    expect(ToolFacade.get_tools_by_id(1266)).to be_a(Tool)
    tool = ToolFacade.get_tools_by_id(1266)

    expect(tool.address).to eq("123 Sunnyside Dr, Lebanon, CA, 46052")
    expect(tool.borrower_id).to eq("nil")
    expect(tool.id).to eq("1266")
    expect(tool.name).to eq("Slammer Saw")
  end
end
