# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'welcome result page' do
  it 'displays chat results', :vcr do
    # chat_prompt = File.read('spec/fixtures/chat_response.json')
    # stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request?project=deck")
    #   .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })
    visit root_path
    expect(page).to have_content('What tools are you looking for?')

    fill_in :project, with: 'deck'

    click_button('Submit')
    expect(current_path).to eq(result_path)
    expect(page).to have_content(['1. Safety glasses', '2. Hammer', '3. Tape measure', '4. Circular saw', '5. Drill',
                                  '6. Post hole digger', '7. Level', '8. Nails or screws', "9. Carpenter's square", '10. Framing square', '11. Joist hangers', '12. Deck screws', '13. Wood preservative', '14. Wood sealant', '15. Deck boards'])
  end

  it 'has secondary tool search after chatbot results', :vcr do
    visit root_path

    tools_search = File.read('spec/fixtures/hammer_search.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/tools/search?name=hammer&location=IN')
      .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

    fill_in :tool, with: 'hammer'
    fill_in :location, with: 'IN'

    click_button('Search')

    expect(current_path).to eq('/tools')
    expect(page).to have_content('Slammer Hammer')
  end
end
