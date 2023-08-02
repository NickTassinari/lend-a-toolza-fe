require 'rails_helper'

RSpec.describe "welcome result page" do 
  it "displays chat results" do 
    chat_prompt = File.read('spec/fixtures/chat_response.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request")
      .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })
    visit root_path
    expect(page).to have_content("What kind of project can we help you with?")
      
    fill_in :project, with: "deck"
      
    click_button("Submit")
    expect(current_path).to eq(result_path)
    expect(page).to have_content("You will need a drill, a circular saw, a hammer, a level, a tape measure, a post hole digger, a framing square, a screwdriver, deck screws, and lag screws. You may also need decking boards, joist hangers, and other hardware specific to your project.")
  end

  it "has secondary tool search after chatbot results" do 
    visit root_path 

    tools_search = File.read('spec/fixtures/hammer_search.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/search?name=hammer&location=IN")
      .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

    fill_in :name, with: "hammer"
    fill_in :location, with: "IN"

    click_button('Search')

    expect(current_path).to eq("/tools")
    expect(page).to have_content("Slammer Hammer")
  end
end