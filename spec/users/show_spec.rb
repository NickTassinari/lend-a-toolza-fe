require "rails_helper"

RSpec.describe "User Show Page" do
  describe "As a logged in User" do
    before(:each) do
      stubbed_response = File.read('spec/fixtures/user_data.json')
      stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/users/1/tools')
      .to_return(status: 200, body: stubbed_response)
    end
    it "I can visit my dashboard" do
      visit "/dashboard"

      within "#title" do
        expect(page).to have_content("Javen's Shed")
      end

      within "#tool_box" do
      expect(page).to have_content("My Toolbox")
      expect(page).to have_button("Add Tool")

        within "#tools" do
          expect(page).to have_content("Hammer")
          expect(page).to have_content("Drill")
          expect(page).to have_content("Pliers")

          within "#tool-hammer" do
            expect(page).to have_content("Available")
          end

          within "#tool-drill" do
            expect(page).to have_content("Available")
          end

          within "#tool-pliers" do
            expect(page).to have_content("Unavailable")
          end
        end
      end

      within "#borrowed_tools" do
        expect(page).to have_content("Borrowed Tools")

        within "#borrow_tools" do
          expect(page).to have_content("Jackhammer")
          expect(page).to have_content("Saw")
        end
      end
    end
  end
end