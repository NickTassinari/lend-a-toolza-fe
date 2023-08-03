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
        expect(page).to have_link("Logout")
        expect(page).to_not have_link("Login")
      end

      it "I can logout" do
        click_link "Login"

        expect(page).to have_link("Logout")

        click_link "Logout"

        expect(current_path).to eq(root_path)
        expect(page).to_not have_link("Logout")
        expect(page).to have_link("Login")
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
        expect(page).to have_content(["1. Hammer", "2. Saw", "3. Safety glasses", "4. Drill", "5. Screwdriver", "6. Level", "7. Tape measure", "8. Chalk line", "9. Nails", "10. Deck screws", "11. Post hole digger", "12. Circular saw", "13. Hacksaw", "14. Shovel", "15. Carpenter’s square", "16. Socket wrench set", "17. Deck boards", "18. Joist hangers", "19. Lag bolts", "20. Galvanized joist hangers"])
      end
    end
  end
end