require "rails_helper"

RSpec.describe "User Show Page" do
  describe "As a logged in User" do
    before(:each) do
      @user1 = User.create!(name: "Test User", email: "test@example.com", google_id: '123456789', location: "46052")

      stubbed_response = File.read("spec/fixtures/users_tools.json")
      stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/users/#{@user1.id}/tools")
      .to_return(status: 200, body: stubbed_response)

      stubbed_response = File.read("spec/fixtures/users_borrowed_tools.json")
      stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/users/#{@user1.id}/tools/borrowed")
      .to_return(status: 200, body: stubbed_response)
    end

    it "I can visit my dashboard" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit dashboard_path(@user1.id) 

      within "#title" do
        expect(page).to have_content("#{@user1.name}'s Shed")
      end

      within "#tool_box" do
      expect(page).to have_content("My Toolbox")
      expect(page).to have_button("Add Tool")

        within "#tools" do
          expect(page).to have_content("Item Excepturi Rem")
          expect(page).to have_content("Item Illum Minus")
          expect(page).to have_content("available")
        end
      end

      within "#borrowed_tools" do
        expect(page).to have_content("Borrowed Tools")

        within "#borrow_tools" do
          expect(page).to have_content("Item Excepturi Rem")
          expect(page).to have_content("Item Illum Minus")
        end
      end
    end
  end
end