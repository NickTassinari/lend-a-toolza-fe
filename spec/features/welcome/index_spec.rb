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
      it "I can login with Google" do

        expect(page).to have_button("Login with Google")

        click_button "Login with Google"

        expect(current_path).to eq(root_path)
        expect(page).to have_button("Logout")
        expect(page).to_not have_button("Login with Google")
      end

      it "I can logout" do
        click_button "Login with Google"

        expect(page).to have_button("Logout")

        click_button "Logout"

        expect(current_path).to eq(root_path)
        expect(page).to_not have_button("Logout")
        expect(page).to have_button("Login with Google")
      end

      it 'can search backend database for tools by name and location' do
        tools_search = File.read('spec/fixtures/hammer_search.json')
        stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/search?name=hammer&location=IN")
          .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

        fill_in :name, with: "hammer"
        fill_in :location, with: "IN"

        click_button('Search')

        expect(current_path).to eq("/tools")
        expect(page).to have_content("Slammer Hammer")

      end

      it "can take in user project to be consumed by backend chat bot" do
        chat_prompt = File.read('spec/fixtures/chat_response.json')
        stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request")
          .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })

        expect(page).to have_content("What kind of project can we help you with?")

        fill_in :project, with: "deck"

        click_button("Submit")

        expect(current_path).to eq(result_path)
        expect(page).to have_content("You will need a drill, a circular saw, a hammer, a level, a tape measure, a post hole digger, a framing square, a screwdriver, deck screws, and lag screws. You may also need decking boards, joist hangers, and other hardware specific to your project.")
      end
    end
  end
end