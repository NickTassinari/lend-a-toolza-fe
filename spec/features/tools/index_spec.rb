require "rails_helper"

RSpec.describe "Tool Index Page" do 
  it "has a list of tools and their attributes" do 
    tools_response = File.read('spec/fixtures/tools_index.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/tools")
      .to_return(status: 200, body: tools_response)

    visit "/tools" 

      expect(page).to have_content("Item Excepturi Rem")
      expect(page).to have_content("Description: Perferendis reprehenderit fugiat sit eos. Corporis ipsum ut. Natus molestiae quia rerum fugit quis. A cumque doloremque magni.")
      expect(page).to have_content("Status: unavailable")
  end
end