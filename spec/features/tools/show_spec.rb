require 'rails_helper'

RSpec.describe "Tool Show Page" do
  before :each do
    tool_data =  {
      "id": "2425",
      "type": "tool",
      "attributes": {
        "name": "Crazy Thors Hammer",
        "description": "Created by the gods",
        "image": "spec/images/astro.jpeg",
        "status": "available",
        "user_id": "12",
        "address": "123 Sunnyside Dr, Lebanon, IN, 46052",
        "latitude": "53.076645",
        "longitude": "10.3398",
        "borrower_id": "33"
      }
    }
    allow(ToolsService).to receive(:get_tools_by_id).with("2425").and_return(tool_data)
    tool = Tool.new(tool_data)

    @user1 = User.create!(name: "Test User", email: "test@example.com", google_id: '123456789', location: "46052")
    stubbed_request = File.read("spec/fixtures/update_tool.json")
    stub_request(:patch, "https://lend-a-toolza-be.onrender.com/api/v1/users/#{@user1.id}/tools/#{tool.id}").to_return(status: 200, body: stubbed_request)

    visit "/tools/#{tool.id}"
  end

  it "shows tool info" do
    expect(page).to have_content("Crazy Thors Hammer")
    expect(page).to have_content("Created by the gods")
    expect(page).to have_content("available")
    expect(page).to have_content("123 Sunnyside Dr, Lebanon, IN, 46052")
    expect(page).to have_css("img[src*='astro.jpeg']")
  end

  it "can borrow a tool" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    expect(page).to have_button("Borrow This Tool")
    expect(page).to have_content("available")
    expect(page).to_not have_content("unavailable")

    click_button "Borrow This Tool"
    save_and_open_page
    expect(current_path).to eq(tool_path("2425"))
    expect(page).to have_content("unavailable")
    expect(page).to_not have_button("Borrow This Tool")
    expect(page).to_not have_content("Available")
  end
end