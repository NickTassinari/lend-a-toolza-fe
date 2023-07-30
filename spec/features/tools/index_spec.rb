require "rails_helper"

RSpec.describe "Tool Index Page" do 
  it "has a list of searched tools and their attributes" do 
    visit root_path
    tools_search = File.read('spec/fixtures/saw_search.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/search?name=saw&location=CA")
      .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

    fill_in :name, with: "saw"
    fill_in :location, with: "CA"

    click_button('Search')
save_and_open_page
    expect(current_path).to eq("/tools")
    expect(page).to have_content("Slammer Saw")
    expect(page).to have_content("Description: This bad boy will cover all your framing needs. Crooked stud? Nail popping up? Wanna just whack something? This hammer is the perfect tool!")
    expect(page).to have_content("Status: available")

  end
end