require "rails_helper"

RSpec.describe "User can login" do
  before(:each) do
    @user1 = User.create!(id: 2, name: "Test User", email: "test@example.com", google_id: '123456789')
    OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(Faker::Omniauth.google)
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

        expect(page).to have_link("Login with Google")

        click_link "Login with Google"

        expect(current_path).to eq(root_path)
        expect(page).to have_link("Logout")
        expect(page).to_not have_link("Login with Google")
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
    end
  end
end