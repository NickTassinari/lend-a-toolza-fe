require 'rails_helper'

RSpec.describe "welcome result page" do 
  it "displays chat results", :vcr do 
    # chat_prompt = File.read('spec/fixtures/chat_response.json')
    # stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request?project=deck")
    #   .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })
    visit root_path
    expect(page).to have_content("What tools are you looking for?")
      
    fill_in :project, with: "deck"
      
    click_button("Submit")
    expect(current_path).to eq(result_path)
    expect(page).to have_content(["1. Circular saw","2. Hammer","3. Drill","4. Deck screws","5. Level","6. Chalk line","7. Tape measure","8. Safety glasses","9. Post hole digger","10. Shovel","11. Joist hangers","12. Nails","13. Deck boards","14. Railing posts","15. Lumber","16. Joist brackets","17. Lag screws","18. Deck railing","19. Paint/stain","20. Deck fasteners"])
  end

  it "has secondary tool search after chatbot results", :vcr do 
    visit root_path 

    tools_search = File.read('spec/fixtures/hammer_search.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/tools/search?name=hammer&location=IN")
      .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

    fill_in :tool, with: "hammer"
    fill_in :location, with: "IN"

    click_button('Search')

    expect(current_path).to eq("/tools")
    expect(page).to have_content("Slammer Hammer")
  end
end