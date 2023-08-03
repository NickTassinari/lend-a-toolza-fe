# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'welcome result page' do
  it 'displays chat results', :vcr do
    visit root_path
    expect(page).to have_content('What tools are you looking for?')

    fill_in :project, with: 'deck'

    click_button('Submit')
    expect(current_path).to eq(result_path)
    expect(page).to have_content(["1. Hammer", "2. Nails", "3. Drill", "4. Screws", "5. Safety glasses", "6. Circular saw", "7. Tape measure", "8. Level", "9. Posthole digger", "10. Deck screws", "11. Deck boards", "12. Joist hangers", "13. Lag screws", "14. Decking screws", "15. Decking materials (wood or composite)", "16. Railing materials (wood or composite)", "17. Sealant", "18. Paint or stain", "19. Sandpaper", "20. Protective clothing"])
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
