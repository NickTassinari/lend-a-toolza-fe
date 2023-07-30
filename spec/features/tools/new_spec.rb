require "rails_helper"

RSpec.describe "New Tool Page" do
  before :each do
    @user1 = User.create!(id: 2, name: "Test User", email: "test@example.com", google_id: '123456789')
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'Test User',
        email: 'test@example.com'
      },
      credentials: {
        token: 'testtoken',
        secret: 'testsecret'
      }
    )
  end
  
  describe "As a visitor" do
    it "Has a form to create a new tool" do
      visit new_tool_path
# save_and_open_page
      expect(current_path).to eq(new_tool_path)
      expect(page).to have_content("Add a New Tool")

      within("#tool_form") do
        expect(page).to have_field("Name")
        expect(page).to have_field("Description")
        expect(page).to have_field("Photo")
      end
    end

    it "Can create a new tool" do
      visit new_tool_path

      expect(current_path).to eq(new_tool_path)

      within("#tool_form") do
        fill_in "Name", with: "Hammer"
        fill_in "Description", with: "A tool to hammer nails"
        fill_in "Tool photo", with: "https://images-na.ssl-images-amazon.com/images/I/71lZ%2BQK%2BZEL._AC_SL1500_.jpg"
      end

      click_button "Add Tool"
    end
  end
end