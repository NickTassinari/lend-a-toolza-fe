require "rails_helper"

RSpec.describe "User can login" do
  before(:each) do
    @user1 = User.create!(name: "Test User", email: "test@example.com", google_id: '123456789')
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
    visit root_path
  end

  describe "As a visitor" do
    describe "When I visit the root path" do
      it "I can login" do

        expect(page).to have_link("Login")

        click_link "Login"

        expect(current_path).to eq(root_path)
        expect(page).to have_button("Logout")
        expect(page).to_not have_link("Login")
      end

      it "I can logout" do
        click_link "Login"

        expect(page).to have_button("Logout")

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to_not have_link("Logout")
        expect(page).to have_link("Login")
      end

      it "I can go to my dashboard" do
        click_link "Login"

        expect(page).to have_link("My Tool Shed")

        click_link "My Tool Shed"
        expect(current_path).to eq(dashboard_path(@user1.id))
      end

      it 'can search backend database for tools by name and location' do
        tools_search = File.read('spec/fixtures/hammer_search.json')
        stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/tools/search?name=hammer&location=IN")
          .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

        fill_in :tool, with: "hammer"
        fill_in :location, with: "IN"

        click_button('Search')

        expect(current_path).to eq("/tools")
        expect(page).to have_content("Slammer Hammer")

      end

      it "can take in user project to be consumed by backend chat bot", :vcr do 
        # chat_prompt = File.read('spec/fixtures/chat_response.json')
        # stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request?project=deck")
        #   .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })
        
        expect(page).to have_content("Not sure what you are looking for?")

        fill_in :project, with: "deck"

        click_button("Submit")

        expect(current_path).to eq(result_path)
        expect(page).to have_content(["1. Hammer","2. Nails","3. Drill","4. Circular Saw","5. Screws","6. Safety Glasses","7. Tape Measure","8. Level","9. Post Hole Digger","10. Pressure-treated Lumber","11. Deck Screws","12. Joist Hangers","13. Flashing","14. Deck Boards","15. Railing Posts","16. Deck Railing","17. Deck Stain or Sealer"])
      end
    end
  end
end